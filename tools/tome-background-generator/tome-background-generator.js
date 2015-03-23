(function() {
  var formIn, format, go, output;

  formIn = {
    bkgd_name: "",
    bkgd_quote: "",
    bkgd_desc: "",
    bkgd_effect: ""
  };

  format = function(id, str) {
    if (str === "") {
      return str;
    } else {
      switch (id) {
        case "bkgd_name":
          return "[b]" + str + ":[/b] ";
        case "bkgd_quote":
          return "\"[i]" + str + "[/i]\" \n";
        case "bkgd_effect":
          return "\n[b]Effect:[/b] " + str + "\n";
        default:
          return str(+"\n");
      }
    }
  };

  output = function(str) {
    var $this, numBreaks;
    numBreaks = (str.match(/\n/g) || []).length;
    $this = $("#output");
    $this.val(str).height(numBreaks * 21);
  };

  go = function(id, str) {
    var k, out, v;
    out = '';
    for (k in formIn) {
      v = formIn[k];
      if (id === k) {
        formIn[k] = format(id, str);
      }
      console.log("ID:: " + id + "FI: " + formIn[k] + " s: " + str);
      if ((formIn[k] != null) && formIn[k] !== "") {
        out += formIn[k];
      }
    }
    return output(out + "[hr]\n");
  };

  $("#left .form-control").on("change input paste keyup", function() {
    return go($(this).attr("id"), $(this).val());
  });

}).call(this);
