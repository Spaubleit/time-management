module Web.View.Replacements.Index where
import Web.View.Prelude

data IndexView = IndexView { replacements :: [Replacement] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={ReplacementsAction}>Replacements</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewReplacementAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Replacement</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach replacements renderReplacement}</tbody>
            </table>
        </div>
    |]


renderReplacement :: Replacement -> Html
renderReplacement replacement = [hsx|
    <tr>
        <td>{replacement}</td>
        <td><a href={ShowReplacementAction (get #id replacement)}>Show</a></td>
        <td><a href={EditReplacementAction (get #id replacement)} class="text-muted">Edit</a></td>
        <td><a href={DeleteReplacementAction (get #id replacement)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
