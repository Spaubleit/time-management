module Web.View.Layout (defaultLayout, Html) where

import IHP.ViewPrelude
import IHP.Environment
import qualified Text.Blaze.Html5            as H
import qualified Text.Blaze.Html5.Attributes as A
import Generated.Types
import IHP.Controller.RequestContext
import Web.Types
import Web.Routes

defaultLayout :: Html -> Html
defaultLayout inner = do 
    let x = currentUser 
    H.docTypeHtml ! A.lang "en" $ [hsx|
        <head>
            {metaTags}

            {stylesheets}
            {scripts}

            <title>Time management</title>
        </head>
        <body>
            <div class="container mt-4">
                <header>
                    <div class="navbar mr-auto">
                        <ul class="navbar-nav">
                            <li class="navbar-item">
                                <a href="/">Home</a>
                            </li>
                        </ul>
                        {userDropdown currentUserOrNothing}
                    </div>
                </header>
                {renderFlashMessages}
                <main>
                    {inner}
                </main>
            </div>
        </body>
    |]

userDropdown :: Maybe User -> Html 
userDropdown (Just user) = [hsx|
    <a class="dropdown" href="#">
        <button 
            class="btn dropdown-toggle" 
            type="button"
            id="menuButton"
            data-toggle="dropdown"
        >
            Not logged in
        </button>
        <div class="dropdown-menu">
            <a class="dropdown-item" href={ShowUserAction $ get #id user}>Profile</a>
            <a class="dropdown-item" href={DeleteSessionAction }>Log out</a>
        </div>
    </a>
|]
userDropdown Nothing = [hsx|
    <a class="dropdown" href="#">
        <button 
            class="btn dropdown-toggle" 
            type="button"
            id="menuButton"
            data-toggle="dropdown"
        >
            Not logged in
        </button>
        <div class="dropdown-menu">
            <a class="dropdown-item" href={NewUserAction}>Log in</a>
            <a class="dropdown-item" href={NewSessionAction}>Register</a>
        </div>
    </a>
|]

stylesheets :: Html
stylesheets = [hsx|
        <link rel="stylesheet" href="/vendor/bootstrap.min.css"/>
        <link rel="stylesheet" href="/vendor/flatpickr.min.css"/>
        <link rel="stylesheet" href="/app.css"/>
    |]

scripts :: Html
scripts = [hsx|
        <script id="livereload-script" src="/livereload.js"></script>
        <script src="/vendor/jquery-3.2.1.slim.min.js"></script>
        <script src="/vendor/timeago.js"></script>
        <script src="/vendor/popper.min.js"></script>
        <script src="/vendor/bootstrap.min.js"></script>
        <script src="/vendor/flatpickr.js"></script>
        <script src="/vendor/morphdom-umd.min.js"></script>
        <script src="/vendor/turbolinks.js"></script>
        <script src="/vendor/turbolinksInstantClick.js"></script>
        <script src="/vendor/turbolinksMorphdom.js"></script>
        <script src="/helpers.js"></script>
        <script src="/ihp-auto-refresh.js"></script>
    |]

metaTags :: Html
metaTags = [hsx|
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta property="og:title" content="App"/>
    <meta property="og:type" content="website"/>
    <meta property="og:url" content="TODO"/>
    <meta property="og:description" content="TODO"/>
    {autoRefreshMeta}
|]
