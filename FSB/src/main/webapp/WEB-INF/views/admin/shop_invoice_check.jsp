<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_invoice_check.jsp // 배송 조회 -->
		<form action="http://info.sweettracker.co.kr/tracking/5" method="post">
            <div class="form-group"><!-- 발급받은 API Key -->
              <input type="hidden" class="form-control" id="t_key" name="t_key" value="OUiXf3yUXBpib5y7ttTjkg">
            </div>
            <div class="form-group">
              <label for="t_code">택배사 코드</label>
             		<select name="t_code" id="t_code" class="form-select">
						<option value="04">CJ대한통운</option>
						<option value="01">우체국택배</option>
						<option value="06">로젠택배</option>
						<option value="05">한진택배</option>
						<option value="08">롯데택배</option>
						<option value="46">CU 편의점택배</option>
					</select>
            </div>
            <div class="form-group">
              <label for="t_invoice">운송장 번호</label>
              <input type="text" class="form-control" name="t_invoice" id="t_invoice" placeholder="운송장 번호">
            </div>
            <button type="submit" class="btn btn-default">조회하기</button>
        </form>
