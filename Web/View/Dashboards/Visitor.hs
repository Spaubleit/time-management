module Web.View.Dashboards.Visitor where

import Web.View.Prelude

data VisitorView = VisitorView

instance View VisitorView where
    html VisitorView = [hsx|<div>Thank you for registration. Let your boss know about it.</div>|]