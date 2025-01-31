%x=(lolcat!='0')*1
%y='header{}'.format(x)
% include(y)


<style>
form{
  padding: 100px;
  display: flex;
  justify-content: center;
  align-items: center;
}
#sname,
#sroll,
#scon,
#sgender,
#sdob,
#syear,
#sbranch,
#sadd,
#shid,
#sflat,#sroom{
  width: 500px;
}

#sname,
#sroll,
#scon,
#sgender,
#sdob,
#syear,
#sbranch
#shid
#sflat,
#sroom{
  height: 50px;
  border-radius: 30px;
}


.containerpage{
  width: 900px;
  border: 1px solid white;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 100px;
  border-radius: 30px;
}
h2{
  font-weight: 600;
}
</style>

<!-- <div class="docs-section" id="forms">
      <h6 class="docs-header">Add new student</h6>
      
      <div class="docs-example docs-example-forms">
        
<form action="/new_student" method="POST">
Name:
  <input type="text"  size="70" maxlength="70" name="name">
 <br>Roll no:
  <input type="number"  name="roll_no">
  <br>Year:
  <input type="number"  name="year">
  <br>Hostel id:
  <input type="number"  name="hostel_id">
  <br>Flat:
  <input type="number"  min="100" max="999" name="flat">
  <br>Room:
  <input type="text"  size="1" maxlength="1" name="room">
  <br>
  <input type="submit" name="save" value="save">
</form>
      </div>
      </div> -->
<!-- `name`, `roll_no`, `dob`, `gender`, `address`, `contact_no`, `year`, `branch`, `hostel_id`, `flat`, `room`)  -->
<div id='ajax_success'></div>
<br/>


<form id="reg" action="/new_emp" method="POST" ><!-- onsubmit=func()-->

<div class="containerpage"> 
<h2>Employee Registration</h2>
<div> 
  <label for="sname">Name</label>
  <input class="u-full-width" type="text" id="sname" maxlength="39" name="1" placeholder="Enter your name" required/>
</div>

  <div> 
      <label for="sroll">Employee id.</label>
      <input class="u-full-width" type="number" id="sroll" maxlength="10" name="2" placeholder="Enter your employee id."/>
   
  </div>
  <div>
      <label for="scon">Contact no.</label>
      <input class="u-full-width" type="tel" id="scon" name="3 " pattern="^\d{10}$" maxlength="10" placeholder="Enter your contact no." required/>
  </div>

  <div>
      <label for="sdob">Date of birth</label>
      <input class="u-full-width" type="date" id="sdob"  name="4" placeholder="Enter your date of birth" style="color:black"required/>
  </div>
      <div>
      <label for="sgender">Gender</label>
      <select class="u-full-width" id="sgender" name="5">
        <option value="f">Female</option>
        <option value="m">Male</option>
      </select>
  </div>

  <div> 
  <label for="sadd">Address</label>
  <textarea class="u-full-width" id="sadd" name="6" placeholder="Enter your address" maxlength="190" required></textarea>
  </div>

  <div> 

  
      <label for="syear">Designation</label>
      <select class="u-full-width" id="syear" name="7" placeholder="Enter your designation" required>
        <option value="cleaning">cleaning</option>
        <option value="warden">warden</option>
        <option value="mess">mess</option>
        <option value="office">office</option>
        <option value="other">other</option>
      </select>
  </div>

<div>
      <label for="shid">Hostel </label>
      <select class="u-full-width" id="shid" name="9" placeholder="Enter your hostel" required>
          <option value="1">Hall of residences</option>
          <option value="2">Studio Apartments</option>
          <option value="3">Silver Springs</option>
      </select>
  
   </div>   

   <div>
      <label for="sflat">Flat no.</label>
      <input class="u-full-width" type="number" id="sflat" min="100" max="999" placeholder="100-999"  name="10" required/>
   </div>

   <div>
      <label for="sroom">Room </label>
      <select class="u-full-width" id="sroom" name="11" placeholder="Enter your room" required>
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
        <option value="D">D</option>
        <option value="E">E</option>
        <option value="H">H</option>
      </select>
   </div>

  <input class="button-primary" type="submit" name="save" value="save">
  </div>

</form>



<script type="text/javascript">
    var frm = $('#reg');

    frm.submit(function (e) {

        e.preventDefault();

        $.ajax({
            type: frm.attr('method'),
            url: frm.attr('action'),
            data: frm.serialize(),
            success: function (data) {

              
                var output = data;
                document.getElementById("ajax_success").innerHTML = '<h5><i>' + output + '</i></h5>';
               $('html, body').animate({
    scrollTop: $("#ajax_success").offset().top - ($("#all").offset().top - $("#all").scrollTop()) -100
}, 'slow');


                console.log('Submission was successful.');
                console.log(data);
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



    

<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>


</html>