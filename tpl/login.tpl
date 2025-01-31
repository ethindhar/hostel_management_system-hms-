<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <title>Hostel Management System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="http://127.0.0.1:8080/css/fonts.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="http://127.0.0.1:8080/dist/css/normalize.css">
  <link rel="stylesheet" href="http://127.0.0.1:8080/dist/css/skeleton.css">
  <link rel="stylesheet" href="./static/css/custom.css">
  <script src="http://127.0.0.1:8080/scripts/jquery.min.js"></script>
  <script src="http://127.0.0.1:8080/scripts/run_prettify.js"></script>
  <link rel="stylesheet" href="http://127.0.0.1:8080/css/github-prettify-theme.css">
  <script src="http://127.0.0.1:8080/js/site.js"></script>


  <style>
    :root {
      --primary: #4f46e5;
      --primary-dark: #3730a3;
      --secondary: #7c3aed;
      --success: #059669;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Roboto', sans-serif;
      min-height: 100vh;
      margin: 0;
      padding: 0;
      position: relative;
      overflow-x: hidden;
      background-color: #0f172a;
    }

    /* Animated Background */
    body::before,
    body::after {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: -1;
    }

    body::before {
      background: radial-gradient(circle at 50% 50%, 
        rgba(79, 70, 229, 0.15) 0%, 
        rgba(124, 58, 237, 0.15) 25%, 
        rgba(45, 212, 191, 0.15) 50%,
        rgba(79, 70, 229, 0.15) 75%);
      filter: blur(7px);
      animation: gradientBG 15s ease infinite;
      background-size: 400% 400%;
    }

    body::after {
      background: 
        radial-gradient(circle at 0% 0%, transparent 50%, rgba(0,0,0,0.5) 100%),
        radial-gradient(circle at 100% 100%, transparent 50%, rgba(0,0,0,0.5) 100%);
      opacity: 0.4;
    }

    @keyframes gradientBG {
      0% { background-position: 0% 50% }
      50% { background-position: 100% 50% }
      100% { background-position: 0% 50% }
    }

    .container {
      width: 100%;
      max-width: 450px;
      margin: 2rem auto;
      padding: 0 1.5rem;
      position: relative;
      z-index: 1;
    }

    .header {
      margin-bottom: 2.5rem;
      text-align: center;
    }

    .title {
      font-size: 2.5rem;
      color: #ffffff;
      font-weight: 700;
      text-align: center;
      margin-bottom: 1rem;
      text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
      letter-spacing: -0.5px;
      animation: fadeInDown 0.8s ease;
    }

    .card {
      background: rgba(255, 255, 255, 0.95);
      padding: 3rem 2.5rem;
      border-radius: 24px;
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255, 255, 255, 0.1);
      animation: fadeIn 0.8s ease;
    }

    .card h5 {
      text-align: center;
      margin-bottom: 2rem;
      font-size: 2rem;
      color: var(--primary-dark);
      font-weight: 600;
      letter-spacing: -0.5px;
    }

    .form-label {
      font-size: 1rem;
      color: #4a5568;
      margin-bottom: 0.5rem;
      font-weight: 500;
      display: block;
      transition: color 0.3s ease;
    }

    .input-field {
      width: 100%;
      padding: 1rem 1.25rem;
      border-radius: 16px;
      border: 2px solid #e2e8f0;
      margin-bottom: 1.5rem;
      font-size: 1.1rem;
      color: #1a202c;
      transition: all 0.3s ease;
      background: rgba(255, 255, 255, 0.9);
    }

    .input-field:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
      outline: none;
    }

    .input-field:focus + .form-label {
      color: var(--primary);
    }

    .button-primary {
      width: 100%;
      padding: 1.25rem;
      background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
      border: none;
      color: white;
      font-size: 1.1rem;
      font-weight: 600;
      border-radius: 16px;
      cursor: pointer;
      transition: all 0.3s ease;
      margin-top: 1.5rem;
      position: relative;
      overflow: hidden;
    }

    .button-primary::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(
        120deg,
        transparent,
        rgba(255, 255, 255, 0.2),
        transparent
      );
      transition: 0.5s;
    }

    .button-primary:hover::before {
      left: 100%;
    }

    .button-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(79, 70, 229, 0.3);
    }

    .button-primary:active {
      transform: translateY(0);
    }

    #ajax_success {
      margin-top: 1.5rem;
      text-align: center;
      font-size: 1rem;
      color: #ffffff;
      background: rgba(5, 150, 105, 0.95);
      padding: 1rem 1.5rem;
      border-radius: 12px;
      display: none;
      animation: slideUp 0.3s ease;
      backdrop-filter: blur(4px);
    }

    #ajax_success:not(:empty) {
      display: block;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @keyframes fadeInDown {
      from { opacity: 0; transform: translateY(-20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @keyframes slideUp {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    /* Responsive Design */
    @media (max-width: 768px) {
      .container {
        padding: 1rem;
        margin: 1rem auto;
      }
      
      .card {
        padding: 2rem 1.5rem;
      }
      
      .title {
        font-size: 2rem;
      }

      .card h5 {
        font-size: 1.75rem;
      }
    }

    @media (max-width: 480px) {
      body {
        padding: 1rem;
      }

      .title {
        font-size: 1.75rem;
      }

      .card {
        padding: 1.5rem 1.25rem;
      }

      .card h5 {
        font-size: 1.5rem;
      }

      .input-field {
        padding: 0.875rem 1rem;
        font-size: 1rem;
      }

      .button-primary {
        padding: 1rem;
      }
    }

    /* Dark mode support */
    @media (prefers-color-scheme: dark) {
      .card {
        background: rgba(30, 41, 59, 0.95);
      }

      .card h5 {
        color: #fff;
      }

      .form-label {
        color: #cbd5e1;
      }

      .input-field {
        background: rgba(30, 41, 59, 0.8);
        border-color: #475569;
        color: #fff;
      }

      .input-field:focus {
        border-color: var(--primary);
      }
    }
  </style>



</head>

<body class="code-snippets-visible">
  <div class="container" id="all">
    <section class="header">
      <h2 class="title">Hostel Management System</h2>
    </section>

    <div class="row">
      <div class="six columns offset-by-three">
        <!-- Modern styled card with login form -->
        <div class="card">
          <h5>Login</h5>
          <form id="loginn" action="/login" method="POST">
            <div class="row">
              <div class="twelve columns">
                <label class="form-label" for="purp">User id.</label>
                <input class="input-field" type="number" id="purp" max="999999999" name="1" required />
              </div>
            </div>
            <div class="row">
              <div class="twelve columns">
                <label class="form-label" for="purp2">Password</label>
                <input class="input-field" type="password" id="purp2" max="999999999" name="2" required />
              </div>
            </div>
            <div class="row">
              <div class="twelve columns">
                <input class="button-primary" type="submit" name="search" value="Login" />
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>

    <div id='ajax_success' class="u-full-width"></div>

    <script type="text/javascript">
      var frm3 = $('#loginn');

      frm3.submit(function (e) {
        e.preventDefault();

        $.ajax({
          type: frm3.attr('method'),
          url: frm3.attr('action'),
          data: frm3.serialize(),
          success: function (data) {
            if (data.redirect) {
              window.location.replace(data.redirect);
            } else {
              var output = data.text;
              document.getElementById("ajax_success").innerHTML = output;
              $('html, body').animate({
                scrollTop: ($("#navid").offset().top)
              }, 'slow');
            }
          },
          error: function (data) {
            alert("error");
            console.log('An error occurred.');
            console.log(data);
          },
        });
      });
    </script>
  </div>
</body>

</html>
