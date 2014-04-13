class MapsController < ApplicationController
  def main
    @interest_points = InterestPoint.active
    @categories = Category.all
    @hash = Gmaps4rails.build_markers(@interest_points) do |interest_point, marker|
      marker.lat interest_point.latitude
      marker.lng interest_point.longitude
      lat = "#{interest_point.latitude}"
      long = "#{interest_point.longitude}"
      image = "#{interest_point.images.first.file_url}"
      name = interest_point.name
      url = "interest_points/#{interest_point.id}"
      marker.infowindow "<h4>Go Here?</h4><a href=#{url}>#{name}</a><br /><img src=#{image} class='image-map-marker'/><br /><button onclick='getLocation(#{lat},#{long})'>GET DIRECTIONS</button>"
    end
  end

  def show
    @interest_points = InterestPoint.where("category_id LIKE ?", "%#{params[:id]}%")
    @categories = Category.all
    @hash = Gmaps4rails.build_markers(@interest_points) do |interest_point, marker|
      marker.lat interest_point.latitude
      marker.lng interest_point.longitude
      lat = "#{interest_point.latitude}"
      long = "#{interest_point.longitude}"
      image = "#{interest_point.images.first.file_url}"
      name = interest_point.name
      url = "/interest_points/#{interest_point.id}"
      marker.infowindow "<h4>Go Here?</h4><a href=#{url}>#{name}</a><br /><img src=#{image} class='image-map-marker'/><br /><button onclick='getLocation(#{lat},#{long})'>GET DIRECTIONS</button>"
    end
  end
end
