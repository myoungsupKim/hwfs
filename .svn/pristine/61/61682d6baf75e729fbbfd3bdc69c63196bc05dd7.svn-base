/**
 * CommonSloWsImplServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package hanwha.neo.branch.common.slo.service;

public class CommonSloWsImplServiceLocator extends org.apache.axis.client.Service implements hanwha.neo.branch.common.slo.service.CommonSloWsImplService {

    public CommonSloWsImplServiceLocator() {
    }


    public CommonSloWsImplServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public CommonSloWsImplServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for CommonSloWsImplPort
    private java.lang.String CommonSloWsImplPort_address = "http://172.16.223.245:80/neo/ws/commonslo";
    //private java.lang.String CommonSloWsImplPort_address = "http://172.16.223.173:80/neo/ws/commonslo";

    public java.lang.String getCommonSloWsImplPortAddress() {
        return CommonSloWsImplPort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String CommonSloWsImplPortWSDDServiceName = "CommonSloWsImplPort";

    public java.lang.String getCommonSloWsImplPortWSDDServiceName() {
        return CommonSloWsImplPortWSDDServiceName;
    }

    public void setCommonSloWsImplPortWSDDServiceName(java.lang.String name) {
        CommonSloWsImplPortWSDDServiceName = name;
    }

    public hanwha.neo.branch.common.slo.service.CommonSloWs getCommonSloWsImplPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(CommonSloWsImplPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getCommonSloWsImplPort(endpoint);
    }

    public hanwha.neo.branch.common.slo.service.CommonSloWs getCommonSloWsImplPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            hanwha.neo.branch.common.slo.service.CommonSloWsImplServiceSoapBindingStub _stub = new hanwha.neo.branch.common.slo.service.CommonSloWsImplServiceSoapBindingStub(portAddress, this);
            _stub.setPortName(getCommonSloWsImplPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setCommonSloWsImplPortEndpointAddress(java.lang.String address) {
        CommonSloWsImplPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (hanwha.neo.branch.common.slo.service.CommonSloWs.class.isAssignableFrom(serviceEndpointInterface)) {
                hanwha.neo.branch.common.slo.service.CommonSloWsImplServiceSoapBindingStub _stub = new hanwha.neo.branch.common.slo.service.CommonSloWsImplServiceSoapBindingStub(new java.net.URL(CommonSloWsImplPort_address), this);
                _stub.setPortName(getCommonSloWsImplPortWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("CommonSloWsImplPort".equals(inputPortName)) {
            return getCommonSloWsImplPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://service.slo.common.branch.neo.hanwha/", "CommonSloWsImplService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://service.slo.common.branch.neo.hanwha/", "CommonSloWsImplPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("CommonSloWsImplPort".equals(portName)) {
            setCommonSloWsImplPortEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
