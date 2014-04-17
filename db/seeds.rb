# This file should contain all the record creation needed to seed the database with its default? values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# This version created by Ashley Childress on 2.1.2014

puts "Starting data seed..."
## Reset Role data
# roles.txt should be formatted as "name"
print "\tStarting Roles..."
Role.delete_all
open("db/default/roles.txt") do |roles|
	roles.read.each_line do |role|
		Role.create!(name: role.chomp)
	end
end
p "DONE!"

## Reset User data 
# comments.txt should be formatted as "user_name|password|first_name|last_name|email|role_id"
print "\tStarting Users.... "
User.delete_all
open("db/default/users.txt") do |users|
	users.read.each_line do |user|
		user_name, pass, first, last, email, role_id = user.chomp.split('|')
		role = Role.find(role_id.to_i)
		User.create!(user_name: user_name, first_name: first, last_name: last, email: email, password: pass, password_confirmation: pass, role: role)
	end
end
p "DONE!"

## Reset Category data
# categories.txt should be formatted as "name"
print "\tStarting Categories..."
Category.delete_all
open("db/default/categories.txt") do |categories|
    categories.read.each_line do |name|
        Category.create!(name: name.chomp)
    end
end
p "DONE!"

## Reset Interest Point Data
# interest_points.txt should be formatted as "name|summary|address_line_1|city|state|zip|category_id|contributor_id|approver_id"
print "\tStarting Interest Points.... "
InterestPoint.delete_all
open("db/default/interest_points.txt") do |interest_points|
	interest_points.read.each_line do |interest_point|
		name, summary, address_1, city, state, zip, category, contributor, approver = interest_point.chomp.split("|")
		approved_at = approver.blank? ? nil : DateTime.now
		InterestPoint.create!(name: name, summary: summary.chomp, address_line_1: address_1, city: city, state: state, zip: zip, category_id: category, created_at: ( DateTime.now - 7.days ), contributor_id: contributor, approver_id: approver, approved_at: approved_at)
	end
end
p "DONE!"

## Reset Image data
# images.txt should be formatted as "interest_point_id|image_file_name|contributor_id|approver_id"; the image_file_name should be the name of the image in this default? folder that should be converted to a photo using carrierwave
print "\tStarting Images.... "
Image.delete_all
open("db/default/images.txt") do |images|
	images.read.each_line do |image|
		interest_point_id, file_name, contributor, approver = image.chomp.split("|")
		file = File.open("db/default/#{file_name}")
		approved_at = approver.blank? ? nil : DateTime.now
		approved_by = approver.blank? ? nil : approver.to_i
		Image.create!(interest_point_id: interest_point_id.to_i, file: file, contributor_id: contributor.to_i, approver_id: approved_by, approved_at: approved_at)
	end
end
p "DONE!"

## Reset Comment data
# comments.txt should be formatted as "interest_point_id|author|body"
print "\tStarting Comments.... "
Comment.delete_all
open("db/default/comments.txt") do |comments|
	comments.read.each_line do |comment|
		author, body = comment.chomp.split("|")
		Comment.create!(author: author, body: body, commentable: InterestPoint.first)
	end
end
p "DONE!"

## Reset Artist data
# artists.txt should be formatted as "first_name|last_name"
print "\tStarting Artists.... "
Artist.delete_all
open("db/default/artists.txt") do |artists|
  artists.read.each_line do |artist|
    f_name, l_name = artist.chomp.split("|")
    Artist.create!(:first_name => f_name, :last_name => l_name)
  end
end
p "DONE"


## Reset Artist Interest Point Associations
# artist_interest_points.txt should be formatted as "artist_id|author|body"
print "\tStarting Artist Interest Points.... "
ArtistInterestPoint.delete_all
open("db/default/artist_interest_points.txt") do |artist_ips|
  artist_ips.read.each_line do |artist_ip|
    artist_id, interest_point_id = artist_ip.chomp.split("|")
    ArtistInterestPoint.create!(:artist_id => artist_id, :interest_point_id => interest_point_id)
  end
end
p "DONE!"

## Reset Report Data
# reports.txt should be formatted as "comment_id|user_id"
print "\tStarting Comment Reports.... "
Report.delete_all
open("db/default/reports.txt") do |reports|
  reports.read.each_line do |report|
    comment, user = report.chomp.split("|")
    Report.create!(:comment_id => comment, :user_id => user)
  end
end
p "DONE!"

## Reset Rating data
# ratings.txt should be formatted as "ratable_type|ratable_id|score|user_id"
#print "\tStarting Ratings.... "
#Rating.delete_all
#open("db/default/ratings.txt") do |interest_point_ratings|
 # interest_point_ratings.read.each_line do |interest_point_rating|
  #  ratable_type, id, score, user = interest_point_rating.split("|")
  #  Rating.create!(ratable_type: ratable_type, ratable_id: id, score: score, user: User.find(user))
  #end
#end
#p "DONE!"

puts "SUCCESS!"
