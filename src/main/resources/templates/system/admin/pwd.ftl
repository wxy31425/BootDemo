<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改密码 </title>
    <meta name="keywords" content="">
    <meta name="description" content="">
     <#include "${ctx!}/inc/include.ftl"/>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <form class="form-horizontal m-t" id="frm">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">原始密码：</label>
                                <div class="col-sm-8">
                                    <input id="oldPassword" name="oldPassword" class="form-control" type="password" placeholder="请输入原始密码">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">新 密 码：</label>
                                <div class="col-sm-8">
                                    <input id="password1" name="password1" class="form-control" type="password" placeholder="请输入新密码">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">重复密码：</label>
                                <div class="col-sm-8">
                                    <input id="password2" name="password2" class="form-control" type="password" placeholder="请输入新密码">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-1 col-sm-offset-4">
                                    <button class="btn btn-primary" type="submit">提交</button>
                                </div>
                                <div class="col-sm-2">
                                    <button class="btn btn-primary" type="reset">重置</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script type="text/javascript">
    $(document).ready(function () {
	    $("#frm").validate({
    	    rules: {
    	    	oldPassword: {
    	        required: true,
    	        minlength: 4,
    	    	maxlength: 10
    	      },
    	      password1: {
    	        required: true,
    	        minlength: 4,
    	    	maxlength: 10
    	      },
    	      password2: {
    	          required: true,
    	          minlength: 4,
    	    	  maxlength: 10,
                  equalTo : "#password1"
    	      }
    	    },
    	    messages: {},
    	    submitHandler:function(form){
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/admin/user/updatePwd",
   	    		   data: $(form).serialize(),
   	    		   success: function(msg){
   	    		   		if(msg.success ==true){
                            layer.msg(msg.message, {time: 2000},function() {
                                window.location.href = "${ctx!}/admin/logout";
                            })
   	    		   		} else{
                            layer.msg(msg.message);
                        }
   	    		   }
   	    		});
            } 
    	});
    });
    </script>

</body>

</html>
