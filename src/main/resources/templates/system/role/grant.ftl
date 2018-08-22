<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>分配菜单</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
     <#include "${ctx!}/inc/include.ftl"/>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <form class="form-horizontal m-t" id="frm">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>角色名称</h5>
                    </div>
                    <div class="ibox-content">
                        <p>为【${role.name}】分配权限</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>选择权限</h5>
                    </div>
                    <div class="ibox-content">
                        <ul id="menuTree"></ul>
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
            </div>
        </div>
       </form>
    </div>

	<script type = "text/javascript">
        var menuIds;
        var resourceIds;
        $(function() {
            getMenuTreeData();
        });

         $("#frm").validate({
             submitHandler: function () {
                 getAllSelectNodes();
                 editSave();
             }
         })

        function loadMenuTree(menuTree) {
            $('#menuTree').jstree({
                "plugins" : [ "wholerow", "checkbox" ],
                'core' : {
                    'data' : menuTree
                },
                "checkbox" : {
                }
            });
            $('#menuTree').jstree('open_all');
        }
        function getAllSelectNodes() {
            var ref = $('#menuTree').jstree(true); // 获得整个树
            menuIds = ref.get_selected(); // 获得所有选中节点的，返回值为数组
            resourceIds = menuIds.join(",");
            console.log(resourceIds)
            $("#menuTree").find(".jstree-undetermined").each(function(i, element) {
                menuIds.push($(element).closest('.jstree-node').attr("id"));
            });
        }

        function getMenuTreeData() {
            $.ajax({
                type : "POST",
                url :"${ctx!}/admin/resource/tree/"+ ${role.id},
                dataType : 'json',
                success : function(data) {
                    loadMenuTree(data);
                }
            });
        }

          function editSave(){
            $.ajax({
                type : "POST",
                url :"${ctx!}/admin/role/grantSave/" + ${role.id},
                dataType : "json",
                data : {"resourceIds":resourceIds},
                success : function(res) {
                    layer.msg(res.message, {time: 2000},function(){
                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        parent.layer.close(index);
                    });
                }
            });
        }
	<#--var setting = {-->
		<#--check : {-->
			<#--enable : true-->
		<#--},-->
		<#--data : {-->
			<#--simpleData : {-->
				<#--enable : true-->
			<#--}-->
		<#--}-->
	<#--};-->
	<#--setting.check.chkboxType = {-->
		<#--"Y" : "ps",-->
		<#--"N" : "s"-->
	<#--};-->




	<#--$(document).ready(function() {-->
		<#--$.ajax({-->
			<#--type : "POST",-->
			<#--url : "${ctx!}/admin/resource/tree/" + ${role.id},-->
			<#--dataType : 'json',-->
			<#--success : function(msg) {-->
			    <#--console.log(msg);-->
				<#--$.fn.zTree.init($("#tree"), setting, msg);-->
			<#--}-->
		<#--});-->
		<#---->
		<#--$("#btnSave").click(function (){-->
			<#--var treeObj = $.fn.zTree.getZTreeObj("tree");-->
			<#--var nodes = treeObj.getCheckedNodes(true);-->
			<#--var selectIds="";-->
			<#--for(var index in nodes){-->
				<#--var item=nodes[index];-->
				<#--selectIds+=item.id+",";-->
			<#--} -->
			<#--$.ajax({-->
				<#--url : "${ctx!}/admin/role/grant/" + ${role.id} + "?t=Math.random()",-->
				<#--type : "post",-->
				<#--dataType : "json",-->
				<#--data : {"resourceIds":selectIds},-->
				<#--success : function(msg) {-->
					<#--layer.msg(msg.message, {time: 2000},function(){-->
   						<#--var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引-->
   						<#--parent.layer.close(index); -->
   					<#--});-->
				<#--},-->
				<#--error : function(r,s,m) {-->
				<#--}-->
			<#--});-->
		<#---->
		<#--});-->
	<#--}); -->
	
	</script>
</body>
</html>
