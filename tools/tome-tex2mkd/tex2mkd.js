//https://rawgit.com/eligrey/FileSaver.js/master/FileSaver.js
//https://cdn.rawgit.com/eligrey/FileSaver.js/master/FileSaver.js --production
//https://rawgit.com/gildas-lormeau/zip.js/master/WebContent/zip.js
//https://cdn.rawgit.com/gildas-lormeau/zip.js/master/WebContent/zip.js -- production

window.onload = function() {
  var len;
  var fileInput = document.getElementById('fileInput');
  var fileDisplayArea = document.getElementById('fileDisplayArea');
  var zip = new JSZip();
  var pending = 0;

  fileInput.addEventListener('change', function (e) {
    len = fileInput.files.length;
    for (var i = 0; i < len; i++) readFile(fileInput.files[i]);
  });

  function readLoad(filename, f2s) {
    fileDisplayArea.innerText += f2s;
    zip.folder('toMarkdown').file(filename + '.md', f2s);
    if (--pending === 0) saveZip();
  }

  function saveZip() {
    var zipBlob = zip.generate({ type:"blob" });
    saveAs( zipBlob, "toMarkdown-" + len + "files.zip");
  }

  function readFile(file) {
    var reader = new FileReader();
    fileDisplayArea.innerText += len + '\n';
    fileDisplayArea.innerText += file.name + '\n';
    reader.addEventListener('load', function (e) { readLoad(file.name, e.target.result); });
    reader.readAsText(file);
    ++pending;
  }

}
