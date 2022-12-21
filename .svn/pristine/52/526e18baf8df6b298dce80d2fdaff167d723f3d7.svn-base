package com.hwfs.fs.fsf.web;

import hone.core.util.record.RecordSet;
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
import com.hwfs.fs.fsf.service.FuneralSaleGoodsInfoMgntService;


 /**
 * 판매상품군 정보관리하는 FuneralSaleGoodsInfoMgnt Controller
 * 
 * @ClassName FuneralSaleGoodsInfoMgntController.java
 * @Description FuneralSaleGoodsInfoMgntController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최문규
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsf/funeralSaleGoodsInfoMgnt/")
public class FuneralSaleGoodsInfoMgntController extends DefaultController {
	
	/** FuneralSaleGoodsInfoMgntService Bean 생성 */
	@Resource(name = "/fs/fsf/funeralSaleGoodsInfoMgntService")
	private FuneralSaleGoodsInfoMgntService funeralSaleGoodsInfoMgntService;
	
	/**
	 * 세트 코드 combo 리스트를 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSetCdCombo.xdo")
	public ModelAndView selectSetCdCombo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//세트코드 combo 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = funeralSaleGoodsInfoMgntService.selectSetCdCombo(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_setCd", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 판매상품등록(TAB1)_매점상품 팝업 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectStoreClassPopupList.xdo")
	public ModelAndView selectStoreClassPopupList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//장례식장 업체정보관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = funeralSaleGoodsInfoMgntService.selectStoreClassPopupList(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_storeGoodsList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 장례식장 판매상품군 정보관리, 세트코드 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectFuneralSaleGoodsInputList.xdo")
	public ModelAndView selectFuneralSaleGoodsInputList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//고인별 판매품목 출고/반품관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		Map<String, RecordSet> rs = funeralSaleGoodsInfoMgntService.selectFuneralSaleGoodsInputList(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_mealClassList", rs.get("mealClass"));
		super.addOutDataSet(mav, "ds_storeClassList", rs.get("storeClass"));
		super.addOutDataSet(mav, "ds_etcClassList", rs.get("etcClass"));
		super.addOutDataSet(mav, "ds_mclassList", rs.get("mClass"));
		super.addOutDataSet(mav, "ds_funeralGoodsList", rs.get("saleClass"));
		super.addOutDataSet(mav, "ds_sclassList", rs.get("sClass"));
		super.addOutDataSet(mav, "ds_saleGoodsTotalList", rs.get("totalList"));
		super.addOutDataSet(mav, "ds_custClassList", rs.get("custList"));
		
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * tab2 콤보변경에 따라 판매상품군을 재조회 한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectTab2GoodsList.xdo")
	public ModelAndView selectTab2GoodsList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//고인별 판매품목 출고/반품관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet tab2GoodsList = funeralSaleGoodsInfoMgntService.selectSaleRegClassList(param.get("ds_search").get(0));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_funeralGoodsList", tab2GoodsList);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * tab2 콤보변경에 따라 판매상품군을 재조회 한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectTab2SetList.xdo")
	public ModelAndView selectTab2SetList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//고인별 판매품목 출고/반품관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet tab2SetList = funeralSaleGoodsInfoMgntService.selectSetList(param.get("ds_search").get(0));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_sclassList", tab2SetList);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 판매상품등록(TAB1)_상품 삭제가능 여부를 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectGoodsDeleteYn.xdo")
	public ModelAndView selectGoodsDeleteYn(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//장례식장 업체정보관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = funeralSaleGoodsInfoMgntService.selectGoodsDeleteYn(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_goodsDeleteYn", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 세트상품등록(TAB1)_상품 삭제가능 여부를 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSetDeleteYn.xdo")
	public ModelAndView selectSetDeleteYn(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//장례식장 업체정보관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = funeralSaleGoodsInfoMgntService.selectSetDeleteYn(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_goodsDeleteYn", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	
	/**
	 * 장례식장 관계자일경우 생성된 세트코드(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveFuneralSaleGoodsInputList.xdo")
	public ModelAndView saveFuneralSaleGoodsInputList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//DataSetMap parameter = param.get("ds_mealClassList");

		//판매상품군 정보관리을(를) 등록, 수정, 삭제 처리한다.
		int cdCnt = funeralSaleGoodsInfoMgntService.saveFuneralSaleGoodsInputList(param);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "cdCnt", cdCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
