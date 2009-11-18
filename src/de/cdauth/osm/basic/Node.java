/*
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
*/

package de.cdauth.osm.basic;

import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import java.util.Hashtable;
import java.util.TreeMap;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

/**
 * Represents a Node in OpenStreetMap.
 */

public class Node extends de.cdauth.osm.basic.Object
{
	static private ObjectCache<Node> sm_cache = new ObjectCache<Node>("node");
	
	protected Node(Element a_dom)
	{
		super(a_dom);
	}
	
	public static ObjectCache<Node> getCache()
	{
		return sm_cache;
	}
	
	public static Hashtable<String,Node> fetch(String[] a_ids) throws IOException, APIError, SAXException, ParserConfigurationException
	{
		return fetchWithCache(a_ids, sm_cache);
	}
	
	public static Node fetch(String a_id) throws IOException, APIError, SAXException, ParserConfigurationException
	{
		return fetchWithCache(a_id, sm_cache);
	}
	
	public static Node fetch(String a_id, String a_version) throws IOException, APIError, SAXException, ParserConfigurationException
	{
		return fetchWithCache(a_id, sm_cache, a_version);
	}
	
	public static Node fetch(String a_id, Date a_date) throws ParseException, IOException, SAXException, ParserConfigurationException, APIError
	{
		return fetchWithCache(a_id, sm_cache, a_date);
	}
	
	public static Node fetch(String a_id, Changeset a_changeset) throws ParseException, IOException, SAXException, ParserConfigurationException, APIError
	{
		return fetchWithCache(a_id, sm_cache, a_changeset);
	}
	
	public static TreeMap<Long,Node> getHistory(String a_id) throws IOException, SAXException, ParserConfigurationException, APIError
	{
		return fetchHistory(a_id, sm_cache);
	}
	
	/**
	 * Returns a LonLat object for the coordinates of this node.
	 */
	
	public LonLat getLonLat()
	{
		return new LonLat(Float.parseFloat(getDOM().getAttribute("lon")), Float.parseFloat(getDOM().getAttribute("lat")));
	}
}
