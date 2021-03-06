<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>菜单编辑</title>
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
                             <#if pid!=0>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">父菜单名称：</label>
                                <div class="col-sm-8">
                                    <input id="" name="pid" type="hidden" value="${pid}">
                                    <input id="" name="" class="form-control" type="text" value="${pName}" readonly>
                                </div>
                            </div>
                            </#if>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">菜单名称：</label>
                                <div class="col-sm-8">
                                    <input id="name" name="name" class="form-control" type="text" placeholder="请输入菜单名称">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">菜单类型：</label>
                                <div class="col-sm-8">
                                    <label class="radio-inline">
                                        <input type="radio" name="type" value="0" /> 目录
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="type" value="1" /> 菜单
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="type" value="2" /> 按钮
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">菜单权限：</label>
                                <div class="col-sm-8">
                                    <input id="sourceKey" name="sourceKey" class="form-control" type="text" placeholder="请输入菜单权限">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">资源url：</label>
                                <div class="col-sm-8">
                                    <input id="url" name="url" class="form-control" type="text"  placeholder="请输入资源url">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">层级：</label>
                                <div class="col-sm-8 ">
                                    <select name="level" class="form-control">
                                        <option value="1">第一级</option>
                                        <option value="2">第二级</option>
                                        <option value="3">第三级</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">排序：</label>
                                <div class="col-sm-8">
                                    <input id="sort" name="sort" class="form-control"  type="text" placeholder="请输入排序值">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">图标：</label>
                                <div class="col-sm-6">
                                    <input id="icon" name="icon" class="form-control" placeholder=" placeholder="例如：fa fa-circle-o">
                                </div>
                                <input id="ico-btn" class="btn btn-success" type="button" value="选择图标">
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">描述详情：</label>
                                <div class="col-sm-8">
                                    <textarea id="description" name="description" class="form-control" type="text" placeholder="详情描述"></textarea>
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
	    $("#frm").validate({
    	    rules: {
    	    	name: {
    	        required: true,
    	        minlength: 4,
    	    	maxlength: 20
    	      },
    	      	sourceKey: {
    	        required: true,
    	    	maxlength: 40
    	      },
    	      	sourceUrl: {
    	        required: true
    	      },
    	      	sort: {
    	      	number:true,
    	        required: true
    	      },
    	      	icon: {
    	        maxlength: 40
    	      }
    	    },
    	    messages: {},
    	    submitHandler:function(form){
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/admin/resource/addSave",
   	    		   data: $(form).serialize(),
                    success: function(res){
                        if(res.success){
                            layer.msg(res.message, {time: 2000},function(){
                                parent.reLoad();
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

        $("#ico-btn").click(function(){
            layer.open({
                type: 2,
                title:'图标列表',
                content:'${ctx!}/admin/resource/font',
                area: ['480px', '90%'],
                success: function(layero, index){
                }
            });
        });


    });
    </script>

</body>
</html>
