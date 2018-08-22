<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员管理</title>
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
                        <h5>用户管理</h5>
                    </div>
                    <div class="ibox-content">
                        <p>
                        	<@shiro.hasPermission name="system:user:add">
                        		<button class="btn btn-success " type="button" onclick="add();"><i class="fa fa-plus"></i>&nbsp;添加</button>
                        	</@shiro.hasPermission>

							<@shiro.hasPermission name="system:user:deleteBatch">
                        		<button class="btn btn-danger " type="button" onclick="deleteBatch();"><i class="fa fa-delete"></i>&nbsp;批量删除</button>
							</@shiro.hasPermission>

                        </p>
                        <hr>
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

    <!-- Page-Level Scripts -->
    <script>
        $(document).ready(function () {
        	//初始化表格,动态从服务器加载数据
			$("#table_list").bootstrapTable({
			    //使用get请求到服务器获取数据
			    method: "POST",
			    //必须设置，不然request.getParameter获取不到请求参数
			    contentType: "application/x-www-form-urlencoded",
			    //获取数据的Servlet地址
			    url: "${ctx!}/admin/user/list",
			    //表格显示条纹
			    striped: true,
			    //启动分页
			    pagination: true,
			    //每页显示的记录数
			    pageSize: 10,
			    //当前第几页
			    pageNumber: 1,
			    //记录数可选列表
			    pageList: [5, 10, 15, 20, 25],
			    //是否启用查询
			    search: true,
			    //是否启用详细信息视图
			    detailView:true,
                showRefresh : true,
                showToggle : true,
                showColumns : true,
                sortable: true,
                sortOrder: "asc",
                iconSize : 'outline',
			    //表示服务端请求
			    sidePagination: "server",
			    //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
			    //设置为limit可以获取limit, offset, search, sort, order
			    queryParamsType: "undefined",
			    //json数据解析
			    responseHandler: function(res) {
			        return {
			            "rows": res.content,
			            "total": res.totalElements
			        };
			    },
			    //数据列
			    columns: [
                    {
                        checkbox : true
                    }, {
			        title: "ID",
			        field: "id",
			        sortable: true
			    },{
			        title: "用户名",
			        field: "userName"
			    },{
			        title: "所属角色",
			        field: "roles",
			        formatter: function(value, row, index) {
                    	var r = "";
                    	$(value).each(function (index,role){
                    		r = r + "【" + role.name + "】";
                    	});
                    	return r;
                    }
			    },{
			        title: "昵称",
			        field: "nickName"

			    },{
			        title: "电话",
			        field: "telephone"
			    },{
			        title: "邮箱",
			        field: "email"
			    },{
			        title: "状态",
			        field: "locked",
			        formatter: function (value, row, index) {
                        if (value == '0')
                        	return '<span class="label label-info">未锁定</span>';
                        return '<span class="label label-danger">已锁定</span>';
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
			        field: "empty",
                    formatter: function (value, row, index) {
                    	var operateHtml = '<@shiro.hasPermission name="system:user:edit"><button class="btn btn-primary btn-xs" type="button" onclick="edit(\''+row.id+'\')"><i class="fa fa-edit"></i>&nbsp;修改</button> &nbsp;</@shiro.hasPermission>';
                    	operateHtml = operateHtml + '<@shiro.hasPermission name="system:user:delete"><button class="btn btn-danger btn-xs" type="button" onclick="del(\''+row.id+'\')"><i class="fa fa-remove"></i>&nbsp;删除</button> &nbsp;</@shiro.hasPermission>';
                        return operateHtml;
                    }
			    }]
			});
        });

        function edit(id){
        	layer.open({
        	      type: 2,
        	      title: '管理员编辑',
        	      shadeClose: true,
        	      shade: false,
                  area: ['1400px', '520px'],
        	      content: '${ctx!}/admin/user/edit/' + id,
        	      end: function(index){
        	    	  $('#table_list').bootstrapTable("refresh");
       	    	  }
        	    });
        }
        function add(){
        	layer.open({
        	      type: 2,
        	      title: '管理员添加',
        	      shadeClose: true,
        	      shade: false,
        	      area: ['1400px', '520px'],
        	      content: '${ctx!}/admin/user/add',
        	      end: function(index){
        	    	  $('#table_list').bootstrapTable("refresh");
       	    	  }
        	    });
        }

        function del(id){
        	layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
        		$.ajax({
    	    		   type: "POST",
    	    		   dataType: "json",
    	    		   url: "${ctx!}/admin/user/delete/" + id,
    	    		   success: function(res){
                           if(res.success){;
                               layer.msg(res.message, {time: 2000},function(){
                                   $('#table_list').bootstrapTable("refresh");
                                   layer.close(index);
                               });
                           } else{
                               layer.msg(res.message);
                           }
                       }
    	    	});
       		});
        }

        function deleteBatch() {
            var rows = $('#table_list').bootstrapTable('getSelections'); // 返回所有选择的行，当没有选择的记录时，返回一个空数组
            if (rows.length == 0) {
                layer.msg("请选择要删除的数据");
                return;
            }
            layer.confirm("确认要删除选中的'" + rows.length + "'条数据吗?", {
                btn : [ '确定', '取消' ]
            }, function() {
                var ids = new Array();
                $.each(rows, function(i, row) {
                    ids[i] = row['id'];
                });
                $.ajax({
                    type : 'POST',
                    dataType: "json",
                    data : {
                        "ids" : ids
                    },
                    url : '${ctx!}/admin/user/batchRemove',
                    success : function(res) {
                        if(res.success){;
                            layer.msg(res.message, {time: 2000},function(){
                                $('#table_list').bootstrapTable("refresh");
                                layer.close();
                            });
                        } else{
                            layer.msg(res.message);
                        }
                    }
              })
		   })
        }
    </script>



</body>

</html>
