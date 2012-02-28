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


if(FALSE) {
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


content = sprintf("This is simple content\n%s\n", Sys.time())
input = RCurl:::uploadFunctionHandler(content, TRUE)
xx = cred$OAuthRequest("https://api-content.dropbox.com/1/files_put/dropbox/Public/up",, "PUT",
                        upload = TRUE, readfunction = input, infilesize = nchar(content), verbose = TRUE)
fromJSON(xx)
               
val = cred$OAuthRequest("https://api-content.dropbox.com/1/files/dropbox/Public/up")
       # Check they are the same, but get rid of attributes, i.e. Content-Type.
identical(as.character(val), as.character(content))


xx = cred$OAuthRequest("https://api.dropbox.com/1/fileops/create_folder",
                        list(root = "dropbox", path = "NewFolder"),  "POST")

xx = cred$OAuthRequest("https://api.dropbox.com/1/fileops/delete",
                        list(root = "dropbox", path = "NewFolder"),  "POST")

xx = cred$OAuthRequest("https://api.dropbox.com/1/fileops/move",
                        list(root = "dropbox", from_path = "Public/up", to_path = "Public/down"),  "POST")              
       
}       
