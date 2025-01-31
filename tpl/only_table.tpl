<style>
#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

#customers td, #customers th {
    border: 1px solid #ddd;
    padding: 8px;
}

#customers tr:nth-child(even) {
    background-color: #f2f2f2;
}

#customers tr:hover {
    background-color: #ddd;
}

#customers th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    background-color: #4CAF50;
    color: white;
}
</style>

<table id="customers" class="u-full-width">
  <thead>
    <tr>
      % for name in columns:
        <th>{{name}}</th>
      % end
    </tr>
  </thead>
  <tbody>
    % for row in rows:
      <tr>
        % for col in row:
          <td>{{col}}</td>
        % end
      </tr>
    % end
  </tbody>
</table>
