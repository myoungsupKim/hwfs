package com.hwfs.fs.fsl.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.fs.fsl.service.UpjangSaleRegMgntCopyService;


 /***
 * 매출등록 카피하는 UpjangSaleRegMgntCopy Controller
 * 
 * @ClassName UpjangSaleRegMgntCopyController.java
 * @Description UpjangSaleRegMgntCopyController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.28    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 :  통협영업 손형민
 * @since 2015.05.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsl/upjangSaleRegMgntCopy/")
public class UpjangSaleRegMgntCopyController extends DefaultController {
	
	/** UpjangSaleRegMgntCopyService Bean 생성 */
	@Resource(name = "/fs/fsl/upjangSaleRegMgntCopyService")
	private UpjangSaleRegMgntCopyService upjangSaleRegMgntCopyService;

	/**
	 * 매출등록 카피(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter = param.get("ds_search").get(0);

		//매출등록 카피을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = upjangSaleRegMgntCopyService.saveList(parameter);
		if(processCnt == -2){
			super.addOutVariable(mav, "fv_processCnt", 0);
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, "복사할 매출이 없습니다.");
		}
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
