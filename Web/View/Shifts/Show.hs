module Web.View.Shifts.Show where
import Web.View.Prelude

data ShowView = ShowView { shift :: Shift }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ShiftsAction}>Shifts</a></li>
                <li class="breadcrumb-item active">Show Shift</li>
            </ol>
        </nav>
        <h1>Show Shift</h1>
        <p>{shift}</p>
    |]
