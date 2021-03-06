/*
	This file is in the public domain, furnished “as is”, without technical
	support, and with no warranty, express or implied, as to its usefulness for
	any purpose.
*/

package eu.cdauth.osm.lib;

/**
 * A geographical object is an object that actually exists somewhere on the map, so it consists of parts that have
 * coordinates. Currently these are nodes, ways and relations.
 * @author cdauth
 */
public interface GeographicalItem extends Item
{
	/**
	 * Returns the IDs all relations that the <strong>current</strong> version of this object is currently contained in.
	 * Relations can only contain geographical objects.
	 * @return The IDs of the relations that contain this object.
	 * @throws APIError There was an error fetching the relations.
	 */
	public ID[] getContainingRelations() throws APIError;
}
