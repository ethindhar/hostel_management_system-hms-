<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <title>Hostel Management System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- External CSS -->
  <link href="/static/css/fonts.css" rel="stylesheet">
  <link rel="stylesheet" href="/static/dist/css/normalize.css">
  <link rel="stylesheet" href="/static/dist/css/skeleton.css">
  <link rel="stylesheet" href="/static/css/custom.css">

  <!-- DataTables CSS -->
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.16/datatables.min.css" />

  <!-- Scripts -->
  <script src="/static/scripts/jquery.min.js"></script>
  <script src="/static/scripts/run_prettify.js"></script>
  <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.16/datatables.min.js"></script>




  <style>
    body {
      font-family: 'Raleway', 'HelveticaNeue', 'Helvetica Neue', Helvetica, Arial, sans-serif;
      background: linear-gradient(135deg, #1a2a6c 0%, #b21f1f 51%, #fdbb2d 100%);
      margin: 0;
      padding: 0;
      min-height: 100vh;
      color: #fff;
    }

    .header {
      text-align: center;
      padding: 2.5rem 0;
      margin-bottom: 2rem;
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(5px);
    }

    .header .title {
      color: #fff;
      font-size: 4rem;
      font-weight: 400;
      margin: 0;
      letter-spacing: -.1rem;
      text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
    }

    .navbar {
      background-color: rgba(0, 0, 0, 0.7);
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
      padding: 1.5rem 0;
      position:sticky;
      top: 0;
      z-index: 1000;
      backdrop-filter: blur(10px);
    }

    .navbar .container {
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .navbar-list {
      list-style: none;
      margin: 0;
      padding: 0;
      display: flex;
      gap: 2rem;
      flex-wrap: wrap;
      justify-content: center;
    }

    .navbar-item {
      position: relative;
    }

    .navbar-link {
      text-decoration: none;
      color: #fff;
      font-size: 1.6rem;
      font-weight: 500;
      padding: 0.8rem 1.5rem;
      border-radius: 6px;
      transition: all 0.3s ease;
    }

    .navbar-link:hover {
      color: #fdbb2d;
      background-color: rgba(255, 255, 255, 0.1);
      transform: translateY(-2px);
    }

    .popover {
      display: none;
      position: absolute;
      top: 100%;
      left: 50%;
      transform: translateX(-50%);
      background-color: rgba(0, 0, 0, 0.9);
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 8px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
      padding: 1rem;
      z-index: 10;
      min-width: 200px;
      margin-top: 1rem;
      backdrop-filter: blur(10px);
    }

    .popover::before {
      content: '';
      position: absolute;
      top: -8px;
      left: 50%;
      transform: translateX(-50%);
      border-width: 0 8px 8px 8px;
      border-style: solid;
      border-color: transparent transparent rgba(0, 0, 0, 0.9) transparent;
    }

    .popover-list {
      list-style: none;
      margin: 0;
      padding: 0;
    }

    .popover-item {
      margin: 0.5rem 0;
    }

    .popover-link {
      text-decoration: none;
      color: #fff;
      font-size: 1.4rem;
      padding: 0.8rem 1.5rem;
      display: block;
      transition: all 0.3s ease;
      border-radius: 4px;
    }

    .popover-link:hover {
      color: #fdbb2d;
      background-color: rgba(255, 255, 255, 0.1);
      transform: translateX(5px);
    }

    .navbar-item:hover .popover {
      display: block;
      animation: fadeIn 0.3s ease;
    }

    @keyframes fadeIn {
      from {
        opacity: 0;
        transform: translateY(-10px) translateX(-50%);
      }
      to {
        opacity: 1;
        transform: translateY(0) translateX(-50%);
      }
    }

    @media (max-width: 1024px) {
      .navbar-list {
        gap: 1rem;
      }
      
      .navbar-link {
        font-size: 1.4rem;
        padding: 0.6rem 1rem;
      }
    }

    @media (max-width: 768px) {
      .header .title {
        font-size: 3rem;
      }

      .navbar {
        padding: 1rem 0;
      }

      .navbar-list {
        flex-direction: column;
        align-items: center;
        gap: 0.5rem;
      }

      .navbar-item {
        width: 100%;
        text-align: center;
      }

      .navbar-link {
        display: block;
        padding: 1rem;
        width: 100%;
        box-sizing: border-box;
      }

      .popover {
        position: static;
        transform: none;
        margin: 0.5rem 0;
        width: 100%;
        box-sizing: border-box;
      }

      .popover::before {
        display: none;
      }

      .popover-link {
        text-align: center;
      }
    }


     
  input[type="text"],
  input[type="number"],
  select,
  textarea {
    color: #333 !important;  
  }

  #ajax_success {
    color: #333 !important;  
  }
  </style>



</head>

<body>
  <!-- Header -->


  <!-- Navbar -->
  <nav class="navbar">
    <div class="container">
      <ul class="navbar-list">
        <li class="navbar-item">
          <a class="navbar-link" href="#" data-popover="#codeNavPopover">Student</a>
          <div id="codeNavPopover" class="popover">
            <ul class="popover-list">
              <li class="popover-item"><a class="popover-link" href="/show_students">Show students</a></li>
              <li class="popover-item"><a class="popover-link" href="/search_student">Search students</a></li>
              <li class="popover-item"><a class="popover-link" href="/new_student">New student</a></li>
              <li class="popover-item"><a class="popover-link" href="/next_year">Next year</a></li>
            </ul>
          </div>
        </li>
        <li class="navbar-item">
          <a class="navbar-link" href="#" data-popover="#codeNavPopover2">Employees</a>
          <div id="codeNavPopover2" class="popover">
            <ul class="popover-list">
              <li class="popover-item"><a class="popover-link" href="/search_emp">Search Employees</a></li>
              <li class="popover-item"><a class="popover-link" href="/new_emp">New employee</a></li>
            </ul>
          </div>
        </li>
        <li class="navbar-item"><a class="navbar-link" href="/update_gate_record">Gate Record</a></li>
        <li class="navbar-item"><a class="navbar-link" href="/update_visitor">Visitor</a></li>
        <li class="navbar-item"><a class="navbar-link" href="/complaint">Complaint</a></li>
        <li class="navbar-item"><a class="navbar-link" href="/courier">Courier</a></li>
        <li class="navbar-item"><a class="navbar-link" href="/event">Events</a></li>
        <li class="navbar-item"><a class="navbar-link" href="/show_hostel">Hostels</a></li>
        <!--<li class="navbar-item"><a class="navbar-link" href="/login">Login</a></li>-->
        <li class="navbar-item"><a class="navbar-link" href="/logout">Logout</a></li>
      </ul>
    </div>
  </nav>
</body>

</html>
