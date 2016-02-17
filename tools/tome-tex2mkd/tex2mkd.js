//https://rawgit.com/eligrey/FileSaver.js/master/FileSaver.js
//https://cdn.rawgit.com/eligrey/FileSaver.js/master/FileSaver.js --production
//https://rawgit.com/gildas-lormeau/zip.js/master/WebContent/zip.js
//https://cdn.rawgit.com/gildas-lormeau/zip.js/master/WebContent/zip.js -- production

window.onload = function() {
  var len, file, reader, blob, f2s, x, i;
  var fileInput = document.getElementById('fileInput');
  var fileDisplayArea = document.getElementById('fileDisplayArea');
  var zip = new JSZip();

  function readLoad( e ) { //peep the bod of current file

    f2s = e.target.result;  // result of reader.readAsText
    /*blob = new Blob([f2s], // setup the files text for saving using saveAs
      type: "text/plain;"
    });*/

    fileDisplayArea.innerText += f2s;
    //saveAs(blob, file.name + ".md");  // save the blob directly as file
    //zip.folder("toMarkdown").file(file.name + ".md", f2s ); // (does not work) save text to be zipped

  };

  fileInput.addEventListener('change', function(e) {
    for (i = 0; i < fileInput.files.length; i++) {

      x = false;
      len = fileInput.files.length;
      file = fileInput.files[i];
      reader = new FileReader();

      fileDisplayArea.innerText += len + '\n';
      fileDisplayArea.innerText += file.name + '\n';

      reader.onload = readLoad;
      reader.readAsText(file);

     zip.file( file.name + ".md", "Test text" );
      //( x ) ? zip.file( file.name + ".md", "Test text" ) : console.log( "x missing " + i);
    }

    //zip.file( file.name + ".md", "Test text" );
    var zipBlob = zip.generate({ type:"blob" });
    saveAs( zipBlob, "toMarkdown-" + len + "files.zip");
  });
}
