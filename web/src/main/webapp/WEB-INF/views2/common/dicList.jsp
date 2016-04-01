<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@include file="../public/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>数据字典管理</title>
    <script type="text/javascript">
        $(function(){
            $('#dataTable').bootstrapTable({
                url:'${ctx}/common/dic/listByPage',
                method:'post',
                contentType:'application/x-www-form-urlencoded',
                sidePagination:'server',
                columns:[[
                    {checkbox:true,width:'5%'},
                    {field:'dicValue',title:'节点名称',width:'25%'},
                    {field:'dicKey',title:'节点代码',width:'15%'},
                    {field:'remark',title:'节点描述',width:'30%'},
                    /*{field:'createTime',title:'创建时间',width:'15%',formatter:function(value,row,index){
                     return new Date(value).format("yyyy-MM-dd");
                     }},*/
                    {field:'_operate',title:'操作',width:'25%',formatter:function(value,row,index){
                        var htm = "<a class='btn btn-default btn-sm' href='javascript:showEditDic(0,"+row.id+")'>编辑</a>";
                        htm += "&nbsp;&nbsp;<a class='btn btn-danger btn-sm' href='javascript:del("+row.id+");'>删除</a>";
                        return htm;
                    }}
                ]],
                singleSelect:true,
                rownumbers:true,
                pagination:true,
                queryParamsType:'ps',
                showPaginationSwitch:true,
                showColumns:true,
                showRefresh:true,
                showToggle:true,
                toolbar:$("#toolbar"),
                queryParams:function(params){
                    params.page = params.pageNumber;
                    params.rows = params.pageSize;
                    params.dicPid=0;
                    return params;
                },
                onLoadError:function(){
                    showErr("加载失败");
                },
                detailView:true,
                detailFormatter:function(index, row, element){
                    loadChild(index,row,element);
                    return $(".childTb_"+row.id).html();
                }
            });
        })

        function loadChild(index,row,ele){
            $("#childTb .childTb_"+row.id).remove();
            $("#childTb").append("<div class='childTb_"+row.id+"'><table id='childTable_"+row.id+"'></table></div>");
            $('#childTable_'+row.id).bootstrapTable({
                cache:false,
                url:'${ctx}/common/dic/getChilds/'+row.id,
                ajaxOptions:{async:false},
                contentType:'application/x-www-form-urlencoded',
                showHeader:true,
                columns:[[
                    {file:"id",width:'4%',formatter:function(value,row,index){
                        return "";
                    }},
                    {field:'dicValue',title:'节点名称',width:'19%'},
                    {field:'dicKey',title:'节点代码',width:'9%'},
                    {field:'remark',title:'节点描述',width:'19%'},
                    /*{field:'createTime',title:'创建时间',width:'15%',formatter:function(value,row,index){
                     return new Date(value).format("yyyy-MM-dd");
                     }},*/
                    {field:'_operate',title:'操作',width:'20%',formatter:function(value,row,index){
                        var htm = "<a class='btn btn-default btn-sm' href='javascript:showEditDic(null,"+row.id+")'>编辑</a>";
                        htm += "&nbsp;&nbsp;<a class='btn btn-danger btn-sm' href='javascript:del("+row.id+");'>删除</a>";
                        return htm;
                    }}
                ]],
                singleSelect:true,
                rownumbers:true,
                pagination:false,
                queryParamsType:'ps',
                queryParams:function(params){
                    params.page = params.pageNumber;
                    params.rows = params.pageSize;
                    return params;
                },
                onLoadError:function(){
                    showErr("加载失败");
                }
            });
        }

        /**
         * @param type 节点类型
         * @param nodeId 节点id 修改的时候传入 新增的时候传空
         */
        function showEditDic(type,nodeId){
            resetForm();
            $("#tmp").html("<div id='tmpResForm' class='tmpForm'></div>");
            $("#tmpResForm").html($("#resForm").html());
            var title;
            if(type == 0){ //新增父节点
                console.log("新增");
                $(".tmpForm #pid").val(0);
                if(nodeId){ //修改
                    showEditChild(nodeId);
                    title = "修改父节点";
                }else{
                    title = "新增父节点";
                }
            }else{ //新增子节点
                var ckds = $('#dataTable').bootstrapTable("getSelections");
                if(ckds.length <= 0) {
                    if(!nodeId) {
                        alert("请选择一行父节点");
                        return;
                    }
                }else{
                    $(".tmpForm #pid").val(ckds[0].id);
                }
                if(nodeId){ //修改子节点
                    showEditChild(nodeId);
                    title = "修改子节点";
                }else{
                    title = "新增子节点";
                }
            }
            dlgWithBtn(title,$("#tmpResForm"),function(){
                saveRes();
            });
        }
        function showEditChild(nodeId){
            $.ajax({
                type:'get',
                url:'${ctx}/common/dic/getById/'+nodeId,
                dataType:'json',
                success:function(data){
                    $(".tmpForm #dic_id").val(data.id);
                    $(".tmpForm #pid").val(data.dicPid);
                    $(".tmpForm #dicValue").val(data.dicValue);
                    $(".tmpForm #dicKey").val(data.dicKey);
                    $(".tmpForm #remark").val(data.remark);
                },
                error:function(err){
                    closeDlg();
                    showErr("加载资源信息失败，请联系管理员");
                }
            });
        }

        function saveRes(){
            $('.tmpForm #ff').bootstrapValidator();
            $('.tmpForm #ff').data("bootstrapValidator").validate();
            if(!$('.tmpForm #ff').data("bootstrapValidator").isValid()) return;
            $.ajax({
                type:'post',
                url:'${ctx}/common/dic/saveOrUpdate',
                data:$('.tmpForm #ff').serializeArray(),
                dataType:'json',
                success:function(data){
                    closeDlg();
                    if(data.status == "200"){
                        showInfo(data.msg);
                    }else{
                        showErr("服务器内部错误，请联系管理员");
                    }
                    reloadGrid();
                },
                error:function(err){
                    closeDlg();
                    showErr("操作失败");
                    reloadGrid();
                }
            });
        }

        function reloadGrid(){
            $('#dataTable').bootstrapTable("refresh");
        }

        function del(id){
            showConfirm("确认提示","确认删除吗？",function(){
                $.ajax({
                    type:'get',
                    url:'${ctx}/common/dic/del/'+id,
                    dataType:'json',
                    success:function(data){
                        if(data.status == "200"){
                            showInfo(data.msg);
                            reloadGrid();
                        }else{
                            showErr("服务器内部错误，请联系管理员");
                        }
                    },
                    error:function(err){
                        showErr("服务器内部错误，请联系管理员");
                    }
                });
            });
        }

        function resetForm(){
            $(".tmpForm #dic_id").val("");
            $(".tmpForm #pid").val("");
            $(".tmpForm #dicValue").val("");
            $(".tmpForm #dicKey").val("");
            $(".tmpForm #remark").val("");
        }

    </script>
</head>
<body class="easyui-layout">
<div class="">
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li class="active">
                    系统管理
                </li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        数据字典
                    </h3>
                </div>

                <div class="panel-body">
                    <div id="toolbar">
                        <a href="javascript:showEditDic(0,null);" class="btn btn-success" style="margin-right:10px;"><span class="glyphicon glyphicon-plus"></span>添加</a>
                        <a href="javascript:showEditDic(null,null);" class="btn btn-success" style="margin-right:160px;"><span class="glyphicon glyphicon-plus"></span>添加子节点</a>
                    </div>
                    <table id="dataTable"></table>
                </div>
            </div>
        </div>
    </div>

    <div class="row" id="resForm" style="display:none;">
        <form id="ff" class="form-horizontal" method="post"  role="form"
              data-bv-message="This value is not valid"
              data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
              data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
              data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
            <input type="hidden" name="id" id="dic_id">
            <input type="hidden" name="dicPid" id="pid">
            <div class="form-group">
                <label for="dicValue" class="col-sm-2 control-label">节点名称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="dicValue" name="dicValue" data-bv-notempty="true" placeholder="节点名称">
                </div>
            </div>
            <div class="form-group">
                <label for="dicKey" class="col-sm-2 control-label">节点代码</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="dicKey" name="dicKey" data-bv-notempty="true" placeholder="节点代码">
                </div>
            </div>
            <div class="form-group">
                <label for="remark" class="col-sm-2 control-label">节点描述</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="remark" name="remark" placeholder="节点描述">
                </div>
            </div>
        </form>

        <div id="childTb" style="display:none;">
            <%--<table id="childTable"></table>--%>
        </div>
        <div id="tmp"></div>
    </div>
</div>
</body>
</html>