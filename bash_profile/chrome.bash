
##### Chrome (FZF)

# c - browse chrome history
#c() {
  #local cols sep google_history open
  #cols=$(( COLUMNS / 3 ))
  #sep='{::}'

  #if [ "$(uname)" = "Darwin" ]; then
    #google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    #open=open
  #else
    #google_history="$HOME/.config/google-chrome/Default/History"
    #open=xdg-open
  #fi
  #cp -f "$google_history" /tmp/h
  #sqlite3 -separator $sep /tmp/h \
    #"select substr(title, 1, $cols), url
     #from urls order by last_visit_time desc" |
  #awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  #fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
#

## Full list of supported Policies: https://www.chromium.org/administrators/policy-list-3

## Ask before accessing physical location.
#defaults write com.google.Chrome DefaultGeolocationSetting -int 3

## Enable the use of a default search provider.
#defaults write com.google.Chrome DefaultSearchProviderEnabled -bool true

## Set the name of the default search provider.
#defaults write com.google.Chrome DefaultSearchProviderName -string "Encrypted Google"

## Set the keyword of the default search provider provider, as trigger, for the omnibox.
#defaults write com.google.Chrome DefaultSearchProviderKeyword -string "google.com"

## Set the search URL of the default search provider.
#defaults write com.google.Chrome DefaultSearchProviderSearchURL -string "https://encrypted.google.com/search?hl=en&q={searchTerms}"

## Disable saving passwords to the password manager.
#defaults write com.google.Chrome PasswordManagerEnabled -bool false

## Protect you and your device from dangerous sites.
#defaults write com.google.Chrome SafeBrowsingEnabled -bool true

## Disable sending system information and page content to Google servers to help detect dangerous apps and sites.
#defaults write com.google.Chrome SafeBrowsingExtendedReportingEnabled -bool false

## Prevent sites with abusive experiences from opening new windows or tabs.
#defaults write com.google.Chrome AbusiveExperienceInterventionEnforce -bool true

## Disallow ads on sites with intrusive ads.
#defaults write com.google.Chrome AdsSettingForIntrusiveAdsSites -int 2

## Disable autofill.
#defaults write com.google.Chrome AutoFillEnabled -bool false

## Disable autofill for credit cards.
#defaults write com.google.Chrome AutofillCreditCardEnabled -bool false

## Disable playing videos automatically (without user consent) with audio content.
#defaults write com.google.Chrome AutoplayAllowed -bool false

## Disallow Add Person from the user manager.
#defaults write com.google.Chrome BrowserAddPersonEnabled -bool false

## Disable guest logins.
#defaults write com.google.Chrome BrowserGuestModeEnabled -bool false

## Don't use built-in DNS client.
#defaults write com.google.Chrome BuiltInDnsClientEnabled -bool false

## Disable usage metrics and diagnostic data, including crash reports, being reported back to Google.
#defaults write com.google.Chrome DeviceMetricsReportingEnabled -bool false

## Disable reporting of usage and crash-related data.
#defaults write com.google.Chrome MetricsReportingEnabled -bool false

## Disable prediction service to load pages more quickly (on any network connection).
#defaults write com.google.Chrome NetworkPredictionOptions -int 2

## Disable prediction service to help complete searches and URLs typed in the address bar.
#defaults write com.google.Chrome SearchSuggestEnabled -bool false

## Disable spell checking web service.
#defaults write com.google.Chrome SpellCheckServiceEnabled -bool false

## Disable synchronization of data with Google.
#defaults write com.google.Chrome SyncDisabled -bool true}
