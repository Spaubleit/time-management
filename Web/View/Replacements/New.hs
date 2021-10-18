module Web.View.Replacements.New where

import Web.View.Prelude

data NewView = NewView 
    { replacement :: Replacement 
    , users :: [User]
    }

instance View NewView where
    html NewView {..} = formFor replacement [hsx|
        {hiddenField #replacableId}
        {hiddenField #state}
        {dateField #date}
        {selectField #substituteId users}
        {submitButton { label = "Create replacement request"}}
    |]