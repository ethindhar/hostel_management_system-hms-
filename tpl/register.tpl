<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #ffecd2, #fcb69f);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .registration-container {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }

        .tabs {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .tabs button {
            flex: 1;
            padding: 1rem;
            border: none;
            background-color: #f1f1f1;
            color: #333;
            font-size: 1.1rem;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;
        }

        .tabs button.active {
            background-color: #007BFF;
            color: #ffffff;
        }

        .form-container {
            display: none;
        }

        .form-container.active {
            display: block;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-size: 1rem;
            color: #555;
            margin-bottom: 0.5rem;
        }

        .form-group input {
            width: 100%;
            padding: 0.8rem;
            font-size: 1rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus {
            border-color: #007BFF;
        }

        .form-group button {
            width: 100%;
            padding: 1rem;
            font-size: 1.2rem;
            background-color: #007BFF;
            border: none;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-group button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <div class="tabs">
            <button id="student-tab" class="active" onclick="showForm('student')">Student Registration</button>
            <button id="warden-tab" onclick="showForm('warden')">Warden Registration</button>
        </div>

        <!-- Student Registration Form -->
        <div id="student-form" class="form-container active">
            <form action="/register_student" method="post">
                <div class="form-group">
                    <label for="student-roll_no">Roll Number:</label>
                    <input type="number" id="student-roll_no" name="roll_no" required>
                </div>
                <div class="form-group">
                    <label for="student-name">Full Name:</label>
                    <input type="text" id="student-name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="student-email">Email Address:</label>
                    <input type="email" id="student-email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="student-password">Password:</label>
                    <input type="password" id="student-password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="student-year">Year:</label>
                    <input type="number" id="student-year" name="year" min="1" max="5" required>
                </div>
                <div class="form-group">
                    <label for="student-department">Department:</label>
                    <input type="text" id="student-department" name="department" required>
                </div>
                <div class="form-group">
                    <button type="submit">Register as Student</button>
                </div>
            </form>
        </div>

        <!-- Warden Registration Form -->
        <div id="warden-form" class="form-container">
            <form action="/register_warden" method="post">
                <div class="form-group">
                    <label for="warden-id">Warden ID:</label>
                    <input type="text" id="warden-id" name="warden_id" required>
                </div>
                <div class="form-group">
                    <label for="warden-name">Full Name:</label>
                    <input type="text" id="warden-name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="warden-email">Email Address:</label>
                    <input type="email" id="warden-email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="warden-phone">Phone Number:</label>
                    <input type="phone" id="warden-phone" name="warden_phone" required>
                </div>
                <div class="form-group">
                    <label for="hostel-id">Hostel ID:</label>
                    <input type="text" id="hostel-id" name="hostel_id" required>
                </div>                                
                <div class="form-group">
                    <label for="warden-password">Password:</label>
                    <input type="password" id="warden-password" name="password" required>
                </div>
                <div class="form-group">
                    <button type="submit">Register as Warden</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function showForm(type) {
            const studentTab = document.getElementById('student-tab');
            const wardenTab = document.getElementById('warden-tab');
            const studentForm = document.getElementById('student-form');
            const wardenForm = document.getElementById('warden-form');

            if (type === 'student') {
                studentTab.classList.add('active');
                wardenTab.classList.remove('active');
                studentForm.classList.add('active');
                wardenForm.classList.remove('active');
            } else {
                wardenTab.classList.add('active');
                studentTab.classList.remove('active');
                wardenForm.classList.add('active');
                studentForm.classList.remove('active');
            }
        }
    </script>
</body>
</html>
