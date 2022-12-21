package com.hwfs.fm.fms.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fm.fms.service.TransactionSpecificationService;
import com.hwfs.fm.fms.service.UpriceContractUpjangSetService;
import com.hwfs.sc.cmn.dto.LoginDTO;


/**
* 거래명세서(브랜드) TransactionSpecificationController Controller
* 
* @ClassName TransactionSpecificationController.java
* @Description TransactionSpecificationController Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2021.08.25   	윤인묵        최초생성
* </pre> 
*/
@Controller
@RequestMapping("/fm/fms/transactionSpecification/")
public class TransactionSpecificationController extends DefaultController {
	
	/** transactionSpecificationService Bean 생성 */
	@Resource(name = "/fm/fms/transactionSpecificationService")
	private TransactionSpecificationService transactionSpecificationService;

	/**
	 * 거래명세서 목록 조회를 수행합니다.
	 * <pre>
	 * 거래명세서 목록 조회
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		// 계약업장 목록 조회
		RecordSet rs = transactionSpecificationService.selectList(parameter);
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 거래명세서 파라미터 저장
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveParamList.xdo")
	public ModelAndView saveReturnList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		
		//거래명세서 임시 파라미터 정보 삭제 후 등록 처리한다.
		int processCnt = transactionSpecificationService.saveParamList(parameter, loginDTO);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
