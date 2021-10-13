module Web.View.Replacements.Show where
import Web.View.Prelude

data ShowView = ShowView { replacement :: Replacement }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ReplacementsAction}>Replacements</a></li>
                <li class="breadcrumb-item active">Show Replacement</li>
            </ol>
        </nav>
        <h1>Show Replacement</h1>
        <p>{replacement}</p>
    |]
