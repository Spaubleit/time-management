module Web.View.Users.Show where
import Web.View.Prelude

data ShowView = ShowView { user :: User }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <h1>Show User</h1>
        <p>{renderUser user}</p>
    |]

renderUser :: User -> Html 
renderUser user = [hsx|
  <label>
    Name
    <div>{get #name user}</div>
  </label>
|]
