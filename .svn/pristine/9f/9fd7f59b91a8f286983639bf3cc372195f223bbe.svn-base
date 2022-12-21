package com.hwfs.fm.fmp.web;

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
import com.hwfs.cmn.token.ValidationToken;
import com.hwfs.fm.fmp.service.ItemSalesDealSheetService;

 /**
 * 
 * @ClassName ItemSalesDealSheetController.java
 * @Description ItemSalesDealSheetController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자          수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.01    안종남   최초생성
 * </pre>
 * @author 안종남
 * @since 2015.07.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmp/itemSalesDealSheet/")
public class ItemSalesDealSheetController extends DefaultController {

   
    /** Bean 생성 */
    @Resource(name = "/fm/fmp/itemSalesDealSheetService")
    private ItemSalesDealSheetService itemSalesDealSheetService;
///////////////////////////////////////////////////////////////////
//식재영업 거래명세서
    
    /**
     * 센터에 대한 업장 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("selectUpjangForCenter2.xdo")
    public ModelAndView selectUpjangForCenter2(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = itemSalesDealSheetService.selectUpjangForCenter2(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 업장에 대한 창고 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("selectSuvinvForUpjang.xdo")
    public ModelAndView selectSuvinvForUpjang(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = itemSalesDealSheetService.selectSuvinvForUpjang(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    /**
     * 센터에 대한 업장 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("selectUpjangForCenter.xdo")
    public ModelAndView selectUpjangForCenter(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = itemSalesDealSheetService.selectUpjangForCenter(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 식재영업 발주점검 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("selectCheckPurchase.xdo")
    public ModelAndView selectCheckPurchase(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
// [속도개선 Project 시작] 2017. 7. 11. 최범주 입고일자별 조회기능 추가
		String frDate = parameter.get("frDate").toString();
		String toDate = parameter.get("toDate").toString();
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 구간 조회할 경우
		if ( !frDate.equals(toDate) ) {
			RecordSet ds_title = itemSalesDealSheetService.selectTitleInfo(parameter);
			super.addOutDataSet(mav, "ds_title", ds_title);
		}
// [속도개선 Project   끝] 2017. 7. 11. 최범주
		
        RecordSet rs = itemSalesDealSheetService.selectCheckPurchase(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    /**
     * 센터 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("selectCenter.xdo")
    public ModelAndView selectCenter(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = itemSalesDealSheetService.selectCenter(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }    
    
    /**
     * 사업부 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("selectMuInfo.xdo")
    public ModelAndView selectMuInfo(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = itemSalesDealSheetService.selectDeptInfo(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    /**
     * 부서조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("selectDeptInfo.xdo")
    public ModelAndView selectDeptInfo(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = itemSalesDealSheetService.selectDeptInfo(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    /**
     * 업장에 대한 사업부 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("selectMuCdForUpjang.xdo")
    public ModelAndView selectMuCdForUpjang(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = itemSalesDealSheetService.selectMuCdForUpjang(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    /**
     * 사번에 대한 업장 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("selectUpjangForSabun.xdo")
    public ModelAndView selectUpjangForSabun(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = itemSalesDealSheetService.selectUpjangForSabun(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }    
	
// [속도개선 Project 시작] 2017. 7. 11. 최범주 입고일자별 조회기능 추가
    /**
     * 입고일 기준일자 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("searchBaseDt.xdo")
    public ModelAndView searchBaseDt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = itemSalesDealSheetService.searchBaseDt(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_baseDt", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }    
// [속도개선 Project   끝] 2017. 7. 11. 최범주
}
