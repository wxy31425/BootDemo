<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>菜单资源管理</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <#include "${ctx!}/inc/include.ftl"/>

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content  animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox ">
                    <div class="ibox-title">
                        <h5>菜单资源管理</h5>
                    </div>
                    <div class="ibox-content">
                        <p>
                        <@shiro.hasPermission name="system:resource:add">
                        	<button class="btn btn-success " type="button" onclick="add('0');"><i class="fa fa-plus"></i>&nbsp;添加根目录</button>
						</@shiro.hasPermission>
                        </p>
                        <div class="row row-lg">
		                    <div class="col-sm-12">
		                        <!-- Example Card View -->
		                        <div class="example-wrap">
		                            <div class="example">
		                            	<table id="table_list"></table>
		                            </div>
		                        </div>
		                        <!-- End Example Card View -->
		                    </div>
	                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            load();
        });
        var load = function() {
        //初始化表格,动态从服务器加载数据
			$("#table_list").bootstrapTreeTable({
                id : "id",
                code : "id",
                parentCode : "pid",
                type : "POST", // 请求数据的ajax类型
                url : "${ctx!}/admin/resource/list", // 请求数据的ajax的url
                ajaxParams : {}, // 请求数据的ajax的data属性
                expandColumn : "1",// 在哪一列上面显示展开按钮
                striped : true, // 是否各行渐变色
                bordered : true, // 是否显示边框
                expandAll : true, // 是否全部展开
				toolbar : '#exampleToolbar',
			    //数据列
			    columns: [{
			        title: "ID",
			        field: "id",
                    visible : false,
                    align : "center",
                    valign : "middle",
                    width : '50px'

			    },{
			        title: "资源名称",
			        field: "name"
			    },{
			        title: "资源KEY",
			        field: "sourceKey"
			    },{
			        title: "资源类型",
			        field: "type",
			        formatter: function(item){
			        	if(item.type == 0)
                    		return '<span class="label label-info">目录</span>';
                    	else if(item.type == 1)
                    		return '<span class="label label-primary">菜单</span>';
                    	else if(item.type == 2)
                    		return '<span class="label label-warning">按钮</span>';
			        }
			    },{
			        title: "资源URL",
			        field: "url"
			    },{
			        title: "排序",
			        field: "sort",
			        sortable: true
			    },{
                    title : '图标',
                    field : 'icon',
                    align : 'center',
                    valign : 'middle',
                    formatter : function(item, index) {
                        return item.icon == null ? '': '<i class="' + item.icon + ' fa-lg"></i>';
                    }
                },{
			        title: "状态",
			        sortable: true,
			        field: "isHide",
                    formatter: function (item) {
                    	if(item.isHide == 0)
                    		return '<span class="label label-info">显示</span>';
                    	else if(item.isHide  == 1)
                    		return '<span class="label label-danger">隐藏</span>';
                    }
			    },{
			        title: "创建时间",
			        field: "createTime",
			        sortable: true
			    },{
			        title: "更新时间",
			        field: "updateTime",
			        sortable: true
			    },{
			        title: "操作",
			        field: "level",
                    formatter: function (item) {
                        if(item.level == 1) {
                            var operateHtml = '<@shiro.hasPermission name="system:resource:edit"><button class="btn btn-primary btn-xs" type="button" onclick="edit(\''+ item.id +'\')"><i class="fa fa-edit"></i>&nbsp;编辑</button> &nbsp;</@shiro.hasPermission>';
                            operateHtml = operateHtml + '<@shiro.hasPermission name="system:resource:delete"><button class="btn btn-danger btn-xs" type="button" onclick="del(\''+ item.id +'\')"><i class="fa fa-remove"></i>&nbsp;删除</button> &nbsp;</@shiro.hasPermission>';
                            operateHtml = operateHtml + '<@shiro.hasPermission name="system:resource:add"><button class="btn btn-primary btn-xs" type="button" onclick="addDown(\''+ item.id +'\')"><i class="fa fa-remove"></i>&nbsp;添加下级</button></@shiro.hasPermission>';
                            return operateHtml;
                        } else if(item.level==2){
                            var operateHtml = '<@shiro.hasPermission name="system:resource:edit"><button class="btn btn-primary btn-xs" type="button" onclick="edit(\''+ item.id +'\')"><i class="fa fa-edit"></i>&nbsp;编辑</button> &nbsp;</@shiro.hasPermission>';
                            operateHtml = operateHtml + '<@shiro.hasPermission name="system:resource:delete"><button class="btn btn-danger btn-xs" type="button" onclick="del(\''+ item.id +'\')"><i class="fa fa-remove"></i>&nbsp;删除</button> &nbsp;</@shiro.hasPermission>';
                            operateHtml = operateHtml + '<@shiro.hasPermission name="system:resource:add"><button class="btn btn-primary btn-xs" type="button" onclick="addDown(\''+ item.id +'\')"><i class="fa fa-remove"></i>&nbsp;添加下级</button></@shiro.hasPermission>';
                            return operateHtml;
                        } else {
                            var operateHtml = '<@shiro.hasPermission name="system:resource:edit"><button class="btn btn-primary btn-xs" type="button" onclick="edit(\''+ item.id +'\')"><i class="fa fa-edit"></i>&nbsp;编辑</button> &nbsp;</@shiro.hasPermission>';
                            operateHtml = operateHtml + '<@shiro.hasPermission name="system:resource:delete"><button class="btn btn-danger btn-xs" type="button" onclick="del(\''+ item.id +'\')"><i class="fa fa-remove"></i>&nbsp;删除</button> &nbsp;</@shiro.hasPermission>';
                            return operateHtml;
                        }
                    }
			    }]
			});
		}

		function reLoad() {
            load();
        }

        function edit(id){
        	layer.open({
        	      type: 2,
        	      title: '菜单编辑',
        	      shadeClose: true,
        	      shade: false,
        	      area: ['893px', '470px'],
        	      content: '${ctx!}/admin/resource/edit/' + id,

        	    });
        }

        function add(id){
            layer.open({
                type: 2,
                title: '添加根目录',
                shadeClose: true,
                shade: false,
                area: ['893px', '470px'],
                content: '${ctx!}/admin/resource/add/'+ id,
            });
        }
        function addDown(id){
        	layer.open({
        	      type: 2,
        	      title: '添加下级',
        	      shadeClose: true,
        	      shade: false,
        	      area: ['893px', '470px'],
        	      content: '${ctx!}/admin/resource/add/'+ id,
        	    });
        }
        function del(id){
        	layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
        		$.ajax({
    	    		   type: "POST",
    	    		   dataType: "json",
    	    		   url: "${ctx!}/admin/resource/delete/" + id,
    	    		   success: function(res){
                           if(res.success){
                               layer.msg(res.message, {time: 2000},function(){
                                   reLoad();
                                   layer.close(index);
                               });
                           } else{
                               layer.msg(res.message);
                           }
                    }
    	    	});
       		});
        }
        
        function detailFormatter(index, row) {
	        var html = [];
	        html.push('<p><b>描述:</b> ' + row.description + '</p>');
	        return html.join('');
	    }
    </script>

    
    

</body>

</html>
