library(ROAuth)
library(RJSONIO)
reqURL <- "https://api.dropbox.com/1/oauth/request_token"
authURL <- "https://www.dropbox.com/1/oauth/authorize"
accessURL <- "https://api.dropbox.com/1/oauth/access_token/"

cKey <-getOption("DropboxKey")
cSecret <-getOption("DropboxSecret")


cred <- OAuthFactory$new(consumerKey = cKey, consumerSecret = cSecret,
                          requestURL = reqURL,accessURL = accessURL,
                           authURL = authURL)
cred$handshake(post = FALSE) 

cred$OAuthRequest("https://api.dropbox.com/1/account/info")

cred$OAuthRequest("https://api-content.dropbox.com/1/files/dropbox/foo")

cred$OAuthRequest("https://api-content.dropbox.com/1/files/dropbox/foo",
                    httpheader = c(Range = "bytes=30-70"), verbose = TRUE)


ll = fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/metadata/dropbox/"))
names(ll$contents) = basename(sapply(ll$contents, `[[`, "path"))
#Make this like file.info
#names(file.info(list.files(".")))
                   


xx = fromJSON(cred$OAuthRequest("https://api.dropbox.com/1/search/dropbox/",
                        list(query = "config", include_deleted = "true")))
               
       
