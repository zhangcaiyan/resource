var editor;
KindEditor.ready(function(K) {
  editor = K.create(".kindeditor", {
    allowFileManager : false,
    fileManagerJson : '/attachments/index',
    uploadJson : '/attachments/upload',
    width : '700px',
    height : '400px',
    afterBlur: function(){
      $(".kindeditor").trigger("blur")
    }
  })
})


