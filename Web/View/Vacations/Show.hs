module Web.View.Vacations.Show where
import Web.View.Prelude

data ShowView = ShowView { vacation :: Vacation }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={VacationsAction}>Vacations</a></li>
                <li class="breadcrumb-item active">Show Vacation</li>
            </ol>
        </nav>
        <h1>Show Vacation</h1>
        <p>{vacation}</p>
    |]
