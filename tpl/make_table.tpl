%x=(lolcat!='0')*1
%y='header{}'.format(x)
% include(y)





<style>
  .table-container {
    margin: 2rem 0;
    background: rgba(255, 255, 255, 0.1);
    padding: 2rem;
    border-radius: 8px;
    backdrop-filter: blur(5px);
  }

  table {
    width: 100%;
    border-collapse: collapse;
    background: rgba(255, 255, 255, 0.9);
    margin-bottom: 1rem;
  }

  th, td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #E1E1E1;
  }

  th {
    background-color: #f4f4f4;
    font-weight: bold;
    color: #333;
  }

  td {
    color: #333;
  }

  tr:nth-child(even) {
    background-color: #f9f9f9;
  }

  tr:hover {
    background-color: #f5f5f5;
  }

  @media (max-width: 768px) {
    .table-container {
      padding: 1rem;
    }

    th, td {
      padding: 8px 10px;
    }
  }
</style>

<div class="table-container">
  <table>
    <tr>
      % for column in columns:
        <th>{{column}}</th>
      % end
    </tr>
    % for row in rows:
      <tr>
        % for cell in row:
          <td>{{cell}}</td>
        % end
      </tr>
    % end
  </table>
</div>


    

<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>

</html>