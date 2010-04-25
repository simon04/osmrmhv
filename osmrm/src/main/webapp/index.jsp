<%--
    This file is part of OSM Route Manager.

    OSM Route Manager is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OSM Route Manager is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with OSM Route Manager.  If not, see <http://www.gnu.org/licenses/>.
--%>
<%@page import="de.cdauth.osm.lib.*"%>
<%@page import="de.cdauth.osm.osmrm.*"%>
<%@page import="static de.cdauth.osm.osmrm.I18n.*"%>
<%@page import="static de.cdauth.osm.osmrm.GUI.*"%>
<%@page import="java.util.*" %>
<%@page contentType="text/html; charset=UTF-8" buffer="none"%>
<%!
	private static final API api = new de.cdauth.osm.lib.api06.API06API();
%>
<%
	GUI gui = new GUI();
	if(!request.getParameterNames().hasMoreElements())
		gui.setDescription(_("OSM Route Manager is a debugging tool for Relations in OpenStreetMap."));
	gui.setJavaScripts(new String[]{ "sortable.js" });

	gui.head(request, response);
%>
<form action="relation.jsp" method="get" id="lookup-form">
	<fieldset>
		<legend><%=htmlspecialchars(_("Lookup relation by ID"))%></legend>
		<dl>
			<dt><label for="i-lookup-id"><%=htmlspecialchars(_("Relation ID"))%></label></dt>
			<dd><input type="text" name="id" id="i-lookup-id" /></dd>

			<dt><label for="i-no-map"><%=htmlspecialchars(_("Don’t show map"))%></label></dt>
			<dd><input type="checkbox" name="norender" id="i-no-map" /></dd>
		</dl>
		<button type="submit"><%=htmlspecialchars(_("Lookup"))%></button>
	</fieldset>
</form>
<form action="#search-form" method="get" id="search-form">
	<fieldset>
		<legend><%=htmlspecialchars(_("Search for relations"))%></legend>
<%
	final String searchKey = (request.getParameter("search-key") != null ? request.getParameter("search-key").trim() : null);
	final String searchValue = (request.getParameter("search-value") != null ? request.getParameter("search-value").trim() : null);
	if(searchKey != null && !searchKey.equals("") && searchValue != null && !searchValue.equals(""))
	{
		try
		{
			Set<Relation> results = api.getRelationFactory().search(new HashMap<String,String>(){{ put(searchKey, searchValue); }});
%>
		<table class="result sortable" id="resultTable">
			<thead>
				<tr>
					<th><%=htmlspecialchars(_("ID"))%></th>
					<th>type</th>
					<th>route</th>
					<th>network</th>
					<th>ref</th>
					<th>name</th>
					<th class="unsortable"><%=htmlspecialchars(_("Open"))%></th>
				</tr>
			</thead>
			<tbody>
<%
			for(Relation result : results)
			{
%>
				<tr>
					<td><%=htmlspecialchars(result.getID().toString())%></td>
					<td><%=htmlspecialchars(result.getTag("type"))%></td>
					<td><%=htmlspecialchars(result.getTag("route"))%></td>
					<td><%=htmlspecialchars(result.getTag("network"))%></td>
					<td><%=htmlspecialchars(result.getTag("ref"))%></td>
					<td><%=htmlspecialchars(result.getTag("name"))%></td>
					<td><a href="relation.jsp?id=<%=htmlspecialchars(urlencode(result.getID().toString()))%>"><%=htmlspecialchars(_("Open"))%></a> (<a href="relation.jsp?id=<%=htmlspecialchars(urlencode(result.getID().toString())+"&norender=on")%>"><%=htmlspecialchars(_("No map"))%></a>)</td>
				</tr>
<%
			}
%>
			</tbody>
		</table>
<%
		}
		catch(Exception e)
		{
%>
		<p class="error"><%=htmlspecialchars(e.getMessage())%></p>
<%
		}
	}
%>
		<dl>
			<dt><label for="i-search-key"><%=htmlspecialchars(_("Key"))%></label></dt>
			<dd><select id="i-search-key" name="search-key">
				<option name="name"<% if("name".equals(request.getParameter("search-key"))){%> selected="selected""<% }%>>name</option>
				<option name="ref"<% if("ref".equals(request.getParameter("search-key"))){%> selected="selected""<% }%>>ref</option>
				<option name="operator"<% if("operator".equals(request.getParameter("search-key"))){%> selected="selected""<% }%>>operator</option>
			</select></dd>

			<dt><label for="i-search-value"><%=htmlspecialchars(_("Value"))%></label></dt>
			<dd><input type="text" id="i-search-value" name="search-value" value="<%=htmlspecialchars(request.getParameter("search-value"))%>" /></dd>
		</dl>
		<input type="submit" value="<%=htmlspecialchars(_("Search using OSM API"))%>" />
	</fieldset>
</form>
<%
	gui.foot(request, response);
%>