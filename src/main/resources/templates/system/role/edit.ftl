<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>角色编辑</title>
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
                        	<input type="hidden" id="id" name="id" value="${role.id}">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">角色key：</label>
                                <div class="col-sm-8">
                                    <input id="roleKey" name="roleKey" class="form-control" type="text" value="${role.roleKey}" <#if role?exists> readonly="readonly"</#if> >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">角色名称：</label>
                                <div class="col-sm-8">
                                    <input id="name" name="name" class="form-control" type="text" value="${role.name}" placeholder="请输入角色名称">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">状态：</label>
                                <div class="col-sm-8">
                                    <label class="radio-inline">
                                        <input id="status0" type="radio" name="status" value="0" data-field="*{dfg}"/> 正常
                                    </label>
                                    <label class="radio-inline">
                                        <input id="status1" type="radio" name="status" value="1"/> 禁用
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">描述：</label>
                                <div class="col-sm-8">
                                    <textarea id="description" name="description" class="form-control" placeholder="请输入描述">${role.description}</textarea>
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
    	    	roleKey: {
    	        required: true,
    	        minlength: 4,
    	    	maxlength: 30
    	      },
    	        name: {
    	        required: true,
    	        minlength: 2,
    	    	maxlength: 30
    	      },
    	        status0: {
    	        required: true
    	      },
                status1: {
                    required: true
                },
    	      	description: {
    	        required: true,
    	        maxlength: 40
    	      }
    	    },
    	    messages: {},
    	    submitHandler:function(form){
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/admin/role/editSave",
   	    		   data: $(form).serialize(),
   	    		   success: function(res){
                       if(res.success){
                           layer.msg(res.message, {time: 2000},function(){
                               var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                               parent.layer.close(index);
                           });
                       } else{
                           layer.msg(res.message);
                       }
   	    		   }
   	    		});
            } 
    	});
    });
    </script>

</body>

</html>
