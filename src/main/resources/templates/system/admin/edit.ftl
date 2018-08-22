<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员编辑</title>
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
                        	<input type="hidden" id="id" name="id" value="${user.id}">
                            <div class="form-group">
                                <label class="col-sm-1 control-label">账户名：</label>
                                <div class="col-sm-4">
                                    <input id="userName" name="userName" class="form-control" type="text" value="${user.userName}" <#if user?exists> readonly="readonly"</#if> >
                                </div>

                                <label class="col-sm-1 control-label">昵称：</label>
                                <div class="col-sm-4">
                                    <input id="nickName" name="nickName" class="form-control" type="text" value="${user.nickName}" placeholder="请输入昵称">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-1 control-label">电话：</label>
                                <div class="col-sm-4">
                                    <input id="telephone" name="telephone" class="form-control" value="${user.telephone}" placeholder="请输入电话">
                                </div>

                                <label class="col-sm-1 control-label">E-mail：</label>
                                <div class="col-sm-4">
                                    <input id="email" name="email" class="form-control" value="${user.email}" placeholder="请输入Email">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label">状态：</label>
                                <div class="col-sm-4">
                                        <label class="radio-inline">
                                            <input id="locked0" type="radio" name="locked" value="0"/> 未锁定
                                        </label>
                                        <label class="radio-inline">
                                            <input id="locked1" type="radio" name="locked" value="1"/> 锁定
                                        </label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="ibox float-e-margins">
                                        <div class="ibox-title">
                                            <h5>选择角色</h5>
                                        </div>
                                        <div class="ibox-content">
                                            <div class="form-group">
                                                <div class="col-sm-12">
												<#if roles??>
													<#if (roles?size > 0)>
														<#list roles as role>
															<div class="checkbox i-checks">
																<label><#if roleIds?seq_contains(role.id)>
                                                                    <input type="checkbox" value="${role.id}" name="roleIds" checked="checked"> <i></i> ${role.name}
											                            <#else>
                                            	                    <input type="checkbox" value="${role.id}" name="roleIds"><i></i> ${role.name}
											                            </#if></label>
															</div>
														</#list>
													</#if>
												</#if>
                                                </div>
                                            </div>
                                        </div>
									</div>
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


    <script>

    $(document).ready(function () {
        $.validator.addMethod("isMobile", function(value, element) {
            var length = value.length;
            var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
            return this.optional(element) || (length == 11 && mobile.test(value));
        }, "请正确填写您的手机号码");


        $("#frm").validate({
    	    rules: {
    	    	userName: {
    	            required: true,
    	            minlength: 4,
    	    	    maxlength: 10
    	      },
    	      	nickName: {
					required: true,
    	            minlength: 4,
    	    	    maxlength: 10
    	      },
                telephone: {
                    required: true,
                    isMobile:true
                },
    	      	email: {
    	      	    email:true,
					required: true
    	      },
                locked0: {
                    required: true
                },
                locked1: {
                    required: true
                }
    	    },
    	    messages: {
                phone: {
                    isMobile:"手机号格式不正确",
                },
			},
    	    submitHandler:function(form){
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/admin/user/editSave",
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
