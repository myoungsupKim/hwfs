package com.hwfs.ms.mom.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.service.ComCacheService;
import com.hwfs.cmn.token.ValidationToken;
import com.hwfs.ms.mom.service.ProductOrderReportService;
import com.hwfs.sc.cmn.service.LoadCacheService;

/**
 * XPLATFORM으로 처리하는 ProductOrderReport Controller
 * 상품발주내역 조회 화면
 * 
 * @ClassName ProductOrderReportController.java
 * @Description ProductOrderReportController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 02. 06.   DSKANG        최초생성
 * </pre>
 * @author FC종합전산구축 : DSKANG
 * @since 2015. 02. 06.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
public class ProductOrderReportController extends DefaultController {
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name = "/ms/mom/productOrderReportService")
	private ProductOrderReportService productOrderReportService;
	
	/**
	 * 상품발주내역(모바일) 조회
	 * <pre>
	 * - 반환되는 데이터의 가능한 형태
	 *   1) RecordSet
	 *   2) List<Map>
	 *   3) List<DTO>
	 * </pre>
	 *
	 * @param xpDTO UI에서 전달되는 통합 Map DTO
	 * @return ModelAndView
	 * @throws Exception
	 */
    //@ValidationToken
    @RequestMapping(value="/ms/mom/selectList.xdo")
	public ModelAndView selectList(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {
    	//Exception 테스트용
    	//int aa = 10/0;
    	
//    	//Cache 테스트용
//    	String cacheId = "TEST-AA";
//    	String cacheVal;
//    	if(cacheService.contains(cacheId)) {
//    		cacheVal = (String) cacheService.get(cacheId, String.class);
//    	}
//    	else {
//    		cacheVal = "TEST_AA Value";
//    		cacheService.put(cacheId, cacheVal);
//    	}

//    	//캐시관리 테스트
//    	List<CacheInfo> cacheInfoList = cacheService.getCacheInfoList();
//    	List<CacheItemInfo> cacheItemInfoList = cacheService.getCacheItemInfoList();
    	
   	
//    	//RequestContext 테스트: ThredLocal
//    	logger.debug("usrid={}", RequestContextUtil.get(DefaultConsts.THREAD_LOCAL_USERID_NAME));
//    	logger.debug("sabun={}", RequestContextUtil.get(DefaultConsts.THREAD_LOCAL_SABUN_NAME));
    	
		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> searchMap = xpDTO.getInVariableMap();
		
		//1)RecordSet으로 반환하는 경우
		//List<Map> list = ProductOrderReportService.selectList(searchMap);
		
		//2)List<Map>으로 반환하는 경우
		List<Map> list = productOrderReportService.selectList(searchMap);

		//3)List<DTO>으로 반환하는 경우
		//List<SampleDTO> list = sampleService.selectSampleListDTO(searchDTO);

		//건수조회
		//int totalCount =  productOrderReportService.selectSampleCount(searchMap);
		
		//결과 데이터셋 설정
		addOutDataSet (mav, "ds_output", list);

		//결과 Variable 설정
		//addOutVariable(mav, "outVarCnt", totalCount);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
    } 	

}
