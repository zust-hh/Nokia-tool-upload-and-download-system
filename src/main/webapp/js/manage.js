$(document).ready(function() {
	$('#query-button').on('click', function() {
		if($('#query-text').val() == '') {
			alert('请输入用户姓名！');
		} else {
			$.ajax({
				type: "post",
				url: "/api/query_uid_by_username",
				data: {
					username: $('#query-text').val()
				},
				dataType: "json",
				async: true,

				success: function(data) {
					$('#query-result').text(data);
				},
				error: function(jqXHR) {
					alert("发生错误：" + jqXHR.status);
				}
			});
		}
	});

});