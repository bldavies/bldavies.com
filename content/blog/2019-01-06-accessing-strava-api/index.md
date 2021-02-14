---
title: Accessing the Strava API with R
---

[Strava](https://www.strava.com/) is an online platform for storing and sharing fitness data.
Strava [provides an API](https://developers.strava.com) for accessing such data at the activity (e.g., run or cycle) level.
This post explains how I [authenticate](#setup-and-authentication) with, and [extract data](#extracting-the-data) from, the Strava API using R.
I implement my method in the R package [stravadata](https://github.com/bldavies/stravadata).

## Setup and authentication

Strava uses [OAuth 2.0](https://oauth.net/2/) to authorise access to the API data.
The first step to becoming authorised is to register for access on [Strava's API settings page](https://www.strava.com/settings/api/).
I put "localhost" in the "Authorization Callback Domain" field.
Upon completing the registration form, the page provides two important values: an integer client ID and an alpha-numeric client secret.
I store these values in `credentials.yaml`, which I structure as

```yaml
client_id: xxxxxxxxx
secret: xxxxxxxxx
```

and import into R using the `read_yaml` function from the [`yaml`](https://cran.r-project.org/package=yaml) package.

Next, I create an OAuth application for interacting with the API and an endpoint through which to send authentication requests.
I use the `oauth_app` and `oauth_endpoint` functions from [`httr`](https://cran.r-project.org/package=httr):

```r
library(httr)

app <- oauth_app("strava", credentials$client_id, credentials$secret)
endpoint <- oauth_endpoint(
  request = NULL,
  authorize = "https://www.strava.com/oauth/authorize",
  access = "https://www.strava.com/oauth/token"
)
```

Finally, I create an OAuth access token to send the authentication request to my Strava account.
This token encapsulates the application and endpoint defined above.
Running[^scope]

```r
token <- oauth2.0_token(endpoint, app, as_header = FALSE,
                        scope = "activity:read_all")
```

[^scope]: Strava's [OAuth update](https://developers.strava.com/docs/oauth-updates/) in October 2019 made `scope` specification a requirement.

opens a browser window at a web page for accepting the authentication request.
Doing so redirects me to the callback domain ("localhost") and prints a confirmation message:

> Authentication complete. Please close this page and return to R.

## Extracting the data

After authenticating with Strava, I use HTTP requests to extract activity data from the API.
The API returns multiple pages of data, each containing up to 200 activities.
I use a while loop to iterate over pages, using the `fromJSON` function from [`jsonlite`](https://cran.r-project.org/package=jsonlite) to parse the extracted data:

```r
library(jsonlite)

df_list <- list()
i <- 1
done <- FALSE
while (!done) {
  req <- GET(
    url = "https://www.strava.com/api/v3/athlete/activities",
    config = token,
    query = list(per_page = 200, page = i)
  )
  df_list[[i]] <- fromJSON(content(req, as = "text"), flatten = TRUE)
  if (length(content(req)) < 200) {
    done <- TRUE
  } else {
    i <- i + 1
  }
}
```

Finally, I use the `rbind_pages` function from `jsonlite` to collate the activity data into a single data frame:

```r
df <- rbind_pages(df_list)
```
