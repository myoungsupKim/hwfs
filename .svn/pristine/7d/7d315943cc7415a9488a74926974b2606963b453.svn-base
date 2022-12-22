package com.hwfs.ma.map.web;

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
import com.hwfs.ma.map.service.ImprovTaskMgmtService;

 /**
 * 
 * @ClassName ImprovTaskMgmtController.java
 * @Description ImprovTaskMgmtController Class 
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
@RequestMapping("/ma/map/improvtaskmgmt")
public class ImprovTaskMgmtController extends DefaultController {

   
    /** Bean 생성 */
    @Resource(name = "/ma/map/improvTaskMgmtService")
    private ImprovTaskMgmtService improvTaskMgmtService;

    
    
///////////////////////////    개선과제 코드 마스터
    
    /**
     * 사업계획 버젼 정보
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("selectVerNm.xdo")
    public ModelAndView selectVerNm(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = improvTaskMgmtService.selectVerNm(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 사업부 정보
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
        
        RecordSet rs = improvTaskMgmtService.selectDeptInfo(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    /**
     * 부서 정보
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
        
        RecordSet rs = improvTaskMgmtService.selectDeptInfo(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    /**
     * 업장에 대한 사업부 정보
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
        
        RecordSet rs = improvTaskMgmtService.selectMuCdForUpjang(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    /**
     * 사번에 대한 업장 정보
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
        
        RecordSet rs = improvTaskMgmtService.selectUpjangForSabun(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    /**
     * 사업부에 대한 개선과제 메인 코드 조회( 대중소 )
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("list.xdo")
    public ModelAndView list(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = improvTaskMgmtService.selectMapImprovCodeMst(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 이전년도 사업부에 대한 개선과제 메인 코드 조회( 대중소 ) 
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("listCopy.xdo")
    public ModelAndView listCopy(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = improvTaskMgmtService.selectMapImprovCodeMst(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 개선과제 메인코드(대중소) 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("selectImprovCode.xdo")
    public ModelAndView selectImprovCode(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = improvTaskMgmtService.selectImprovCode(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
   /**
	 * 사업부에 대한 개선과제 메인코드(대중소) 저장을 수행합니다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("save.xdo")
	public ModelAndView save(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
	{
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = improvTaskMgmtService.saveMapImprovCodeMst(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 사업부에 대한 전년도 개선과제 메인코드(대중소) 저장을 수행
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("saveCopy.xdo")
	public ModelAndView saveCopy(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
	{
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = improvTaskMgmtService.saveCopyMapImprovCodeMst(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 해당 년도 사업부에 대한 개선과제 메인코드(대중소) 삭제
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("remove.xdo")
	public ModelAndView remove(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
	{
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = improvTaskMgmtService.removeMapImprovCodeMst(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
    

    /**
     * 개선계획 관리 화면 상단 그리드 조회 
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("list2.xdo")
    public ModelAndView list2(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = improvTaskMgmtService.selectMapImprovMgtMst(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    
   /**
	 * 개선계획 관리 화면 상단 그리드 저장을 수행
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("save2.xdo")
	public ModelAndView save2(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
	{
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = improvTaskMgmtService.saveMapImprovMgtMst(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 개선계획 관리 화면 상단 그리드 삭제
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("remove2.xdo")
	public ModelAndView remove2(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
	{
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = improvTaskMgmtService.removeMapImprovMgtMst(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	/**
     * 유관부서 지원사항 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("list6.xdo")
    public ModelAndView list6(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = improvTaskMgmtService.selectMapImprovSupportForEmpNo(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
	
	
	/**
     * 유관부서 지원사항 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("list3.xdo")
    public ModelAndView list3(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = improvTaskMgmtService.selectMapImprovSupport(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    
   /**
	 * 유관부서 지원사항 저장
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("save3.xdo")
	public ModelAndView save3(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
	{
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = improvTaskMgmtService.saveMapImprovSupport(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 유관부서 지원사항 삭제
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("remove3.xdo")
	public ModelAndView remove3(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
	{
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = improvTaskMgmtService.removeMapImprovSupport(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	

	/**
     * 개선과제 계정정보(PL) 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("list4.xdo")
    public ModelAndView list4(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = improvTaskMgmtService.selectMapImprovPlDtl(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 개선과제 계정정보(PL) 합계 저장
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("listSum4.xdo")
    public ModelAndView listSum4(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = improvTaskMgmtService.selectMapImprovPlDtlSum(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    
   /**
	 * 개선과제 계정정보(PL) 저장 
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("save4.xdo")
	public ModelAndView save4(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
	{
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = improvTaskMgmtService.saveMapImprovPlDtl(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 개선과제 계정정보(PL) 삭제
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("remove4.xdo")
	public ModelAndView remove4(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
	{
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = improvTaskMgmtService.removeMapImprovPlDtl(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}


	/**
     * 계정정보 조회
     *
     * @param xpDto
     *        XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *        ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
  	@SuppressWarnings("unchecked")
    @RequestMapping("list5.xdo")
    public ModelAndView list5(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
    {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        Map<String, Object> parameter = param.get("ds_search").get(0);
        
        RecordSet rs = improvTaskMgmtService.selectMapAcctCdInfo(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    
   /**
	 * 계정정보 저장(현재 다른 로직으로 대체)
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("save5.xdo")
	public ModelAndView save5(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
	{
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = improvTaskMgmtService.saveMapAcctCdInfo(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 계정정보 삭제
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("remove5.xdo")
	public ModelAndView remove5(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception 
	{
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		
		int processCnt = improvTaskMgmtService.removeMapAcctCdInfo(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
}
