<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>系统日志管理</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <#include "${ctx!}/inc/include.ftl"/>
  <style>
      .cross{
          margin-left: 1%;
      }
  </style>

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox ">
                <div class="ibox-title">
                    <h5>系统日志管理</h5>
                </div>
                <div class="ibox-content">
                    <div class="form-inline" role="form">
                        <div class="form-group cross">
                        <label class="control-label">请求类型：</label>
                            <select name="request" class="form-control" id="request">
                                <option value="" >请选择</option>
                                <option value="普通请求">普通请求</option>
                                <option value="Ajax请求">Ajax请求</option>
                            </select>
                         </div>
                         <div class="form-group cross">
                            <label class="control-label">用户名：</label>
                            <input  id="searchName" type="text" class="form-control" placeholder="请输入账号"/>
                        </div>

                        <div class="form-group cross">
                            <label class="control-label">操作方式：</label>
                            <select name="level" class="form-control" id="level">
                                <option  value="" >请选择</option>
                                <option value="GET">GET</option>
                                <option value="POST">POST</option>
                            </select>
                        </div>
                        <button class="btn btn-primary cross" onclick="reLoad()">查询</button>
                        	<@shiro.hasPermission name="system:log:deleteBatch">
                        		<button class="btn btn-danger col-md-offset-5" type="button" onclick="deleteBatch();"><i class="fa fa-remove"></i>&nbsp;批量删除</button>
                            </@shiro.hasPermission>

                    </div>
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
    // $(function() {
        load();
    // });
    function load() {
        //初始化表格,动态从服务器加载数据
        $("#table_list").bootstrapTable({
            //使用get请求到服务器获取数据
            method: "POST",
            //必须设置，不然request.getParameter获取不到请求参数
            contentType: "application/x-www-form-urlencoded",
            //获取数据的Servlet地址
            url: "${ctx!}/admin/log/list",
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
            showRefresh: true,
            showToggle: true,
            showColumns: true,
            //表示服务端请求
            sidePagination: "server",
            //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
            //设置为limit可以获取limit, offset, search, sort, order
            queryParamsType: "",
            queryParams:function(params) {
                var params = {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize,
                    searchName: $("#searchName").val(),
                    level: $("#level").val(),
                    request: $("#request").val(),
                };
                return params;
            },

            //json数据解析
            responseHandler: function (res) {
                return {
                    "rows": res.content,
                    "total": res.totalElements

                };

            },
            //数据列
            columns: [
                {
                    checkbox: true
                }, {
                    title: "请求类型",
                    field: "type"
                }, {
                    title: "行为",
                    field: "title"
                }, {
                    title: "来源",
                    field: "remoteAddr",
                }, {
                    title: "操作者",
                    field: "userName",
                }, {
                    title: "请求地址",
                    field: "requestUri",
                }, {
                    title: "操作方式",
                    field: "httpMethod",
                }, {
                    title: "请求方法",
                    field: "classMethod",
                }, {
                    title: "浏览器",
                    field: "browser",
                }, {
                    title: "创建时间",
                    field: "createTime",
                    width: "10%"
                }, {
                    title: "操作",
                    field: "empty",
                    formatter: function (value, row, index) {
                        var operateHtml = '<@shiro.hasPermission name="system:log:delete"><button class="btn btn-danger btn-xs" type="button" onclick="del(\''+ row.id +'\')"><i class="fa fa-remove"></i>&nbsp;删除</button> &nbsp;</@shiro.hasPermission>';
                        return operateHtml;
                    }
                }]
        });
    }

    function del(id){
        layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
            $.ajax({
                type: "POST",
                dataType: "json",
                url: "${ctx!}/admin/log/delete/" + id,
                success: function(res){
                    if(res.success){
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
                url : '${ctx!}/admin/log/batchRemove',
                success : function(res) {
                    if(res.success){
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

    function reLoad() {
        $('#table_list').bootstrapTable("refresh");

    }



</script>

</body>

</html>
