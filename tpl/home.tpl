<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Management System</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #ffecd2, #fcb69f);
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 100%;
            max-width: 500px;
            padding-top: 2rem;
        }

        .header {
            margin-top: 0;
        }

        .card {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
        }

        .card h5 {
            text-align: center;
            margin-bottom: 1rem;
            font-size: 1.5rem;
            color: #333;
        }

        .button-primary {
            width: 100%;
            padding: 1rem;
            background-color: #007BFF;
            border: none;
            color: white;
            font-size: 1.2rem;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;
            margin-bottom: 1rem;
        }

        .button-primary:hover {
            background-color: #0056b3;
        }

        .title {
            font-size: 2.5rem;
            color: #333;
            font-weight: 600;
            text-align: center;
            margin-bottom: 1rem;
        }

        .subtitle {
            font-size: 1rem;
            color: #555;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        a {
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <h1 class="title">Hostel Management System</h1>
            <p class="subtitle">Click the button below to log in to your account or register as a new user.</p>
            <a href="/login">
                <button class="button-primary">Login</button>
            </a>
            <a href="/register">
                <button class="button-primary">Register</button>
            </a>
        </div>
    </div>

    <!-- Chatbot script -->
    <script>
        (function(){
            if(!window.chatbase || window.chatbase("getState") !== "initialized") {
                window.chatbase = (...arguments) => {
                    if(!window.chatbase.q) { 
                        window.chatbase.q = []; 
                    }
                    window.chatbase.q.push(arguments);
                };
                window.chatbase = new Proxy(window.chatbase, {
                    get(target, prop) {
                        if (prop === "q") { 
                            return target.q; 
                        }
                        return (...args) => target(prop, ...args);
                    }
                });
            }
            const onLoad = function() {
                const script = document.createElement("script");
                script.src = "https://www.chatbase.co/embed.min.js";
                script.id = "uOhZaBEiqJEWm158LmkVG";
                script.domain = "www.chatbase.co";
                document.body.appendChild(script);
            };
            if(document.readyState === "complete") {
                onLoad();
            } else {
                window.addEventListener("load", onLoad);
            }
        })();
    </script>
</body>
</html>
