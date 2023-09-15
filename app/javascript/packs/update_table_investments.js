$(document).on('turbolinks:load', function() {
    let investment_input = document.getElementById('investment');
    let url_path = investment_input.getAttribute("data-url");
    let timeout = null;
    investment_input.addEventListener('input', function() {
      
      clearTimeout(timeout);
      timeout = setTimeout(function() {
        get_investments(parseFloat(investment_input.value), url_path);
      }, 1000);
    });

});


function get_investments(investment, url){
  let loading = document.getElementById("loading");
  let table = document.getElementById("investments");
  let export_csv = document.getElementById("export_csv");
  let export_json = document.getElementById("export_json");
  table.classList.add("visually-hidden");
  loading.classList.remove("visually-hidden");
  $.ajax({
    url: url,
    data: { "inversment": investment },
    type: "GET",
    success: function(response) {
      $('#investments > tbody').empty();
      $('#investments > tbody').append(response.annual_investments);
      url = export_csv.href.split("=")[0] +"=" + encodeURIComponent(response.csv_data);
      export_csv.href = url;
      url = export_json.href.split("=")[0] +"=" + encodeURIComponent(response.json_data);
      export_json.href = url;
    },
    error: function(xhr) {
      console.log(xhr)
    },
    complete: function() {
      loading.classList.add("visually-hidden");
      table.classList.remove("visually-hidden")
    }
  });
}