package auth

import (
	"context"
	"fmt"
	"log"
	"os"
	"strconv"
	"time"

	jwt "github.com/appleboy/gin-jwt/v2"
	"github.com/christian-heusel/explorer-app/server/graph/model"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

var identityKey = "id"

type login struct {
	ID       string `form:"id" json:"id" binding:"required"`
	Password string `form:"password" json:"password" binding:"required"`
}

// InitJWTMiddleware Returns a JWT Middleware for authentification.
func InitJWTMiddleware(db *gorm.DB) *jwt.GinJWTMiddleware {
	// the jwt middleware
	authMiddleware, err := jwt.New(&jwt.GinJWTMiddleware{
		Realm:       "Explorer App",
		Key:         []byte(os.Getenv("JWT_SECRET_KEY")),
		Timeout:     time.Hour,
		MaxRefresh:  time.Hour,
		IdentityKey: identityKey,
		PayloadFunc: func(data interface{}) jwt.MapClaims {
			if v, ok := data.(*model.Team); ok {
				return jwt.MapClaims{
					identityKey: fmt.Sprint(v.ID),
				}
			}
			return jwt.MapClaims{}
		},
		IdentityHandler: func(c *gin.Context) interface{} {
			claims := jwt.ExtractClaims(c)
			i, err := strconv.Atoi(claims[identityKey].(string))
			if err != nil {
				log.Println(err)
				return nil
			}
			var team model.Team
			db.Where(&model.Team{ID: i}).First(&team)
			return &team
		},
		Authenticator: func(c *gin.Context) (interface{}, error) {
			var loginVals login
			if err := c.ShouldBind(&loginVals); err != nil {
				log.Println(err)
				return "", jwt.ErrMissingLoginValues
			}
			teamID := loginVals.ID
			password := loginVals.Password
			i, err := strconv.Atoi(teamID)
			if err != nil {
				log.Println(err)
				return nil, fmt.Errorf("No user supplied")
			}
			var team model.Team
			db.Where(&model.Team{ID: i}).First(&team)
			if team.Authcode == password {
				return &team, nil
			}

			return nil, jwt.ErrFailedAuthentication
		},
		Authorizator: func(data interface{}, c *gin.Context) bool {
			if _, ok := data.(*model.Team); ok {

				return true
			}
			return false
		},
		Unauthorized: func(c *gin.Context, code int, message string) {
			c.JSON(code, gin.H{
				"code":    code,
				"message": message,
			})
		},
		// TokenLookup is a string in the form of "<source>:<name>" that is used
		// to extract token from the request.
		// Optional. Default value "header:Authorization".
		// Possible values:
		// - "header:<name>"
		// - "query:<name>"
		// - "cookie:<name>"
		// - "param:<name>"
		TokenLookup: "header: Authorization",
		// TokenLookup: "query:token",
		// TokenLookup: "cookie:token",

		// TokenHeadName is a string in the header. Default value is "Bearer"
		TokenHeadName: "Bearer",

		// TimeFunc provides the current time. You can override it to use another time value. This is useful for testing or if your server uses a different time zone than your tokens.
		TimeFunc: time.Now,
	})
	if err != nil {
		log.Fatal("JWT Error:" + err.Error())
	}
	return authMiddleware
}

//TeamFromContextToContext stores the current logged in team in ctx
func TeamFromContextToContext() gin.HandlerFunc {
	return func(c *gin.Context) {
		team, _ := c.Get(identityKey)
		ctx := context.WithValue(c.Request.Context(), identityKey, team.(*model.Team))
		c.Request = c.Request.WithContext(ctx)
		c.Next()
	}
}

// TeamFromContext retrieves the current authenticated team from Context
func TeamFromContext(ctx context.Context) (*model.Team, error) {
	team := ctx.Value("id")
	if team == nil {
		err := fmt.Errorf("could not retrieve model.Team")
		return nil, err
	}

	gc, ok := team.(*model.Team)
	if !ok {
		err := fmt.Errorf("model.Team has wrong type")
		return nil, err
	}
	return gc, nil
}
