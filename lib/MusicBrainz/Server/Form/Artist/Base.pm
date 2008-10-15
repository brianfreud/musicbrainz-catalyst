package MusicBrainz::Server::Form::Artist::Base;

use strict;
use warnings;

use base 'MusicBrainz::Server::Form::EditForm';

use ModDefs;
use Moderation;
use MusicBrainz;
use MusicBrainz::Server::Artist;

=head1 NAME

MusicBrainz::Server::Form::Artist - form representation for creating
and editing artists.

=head1 DESCRIPTION

This handles the validation of form fields, along with inserting the
new data into the database appropriatly.

=head1 METHODS

=head2 profile

Returns a hash reference of fields that are in this form, organised by
required and optional fields.

=cut

sub profile
{
    return {
        required => {
            name        => 'Text',
            sortname    => 'Text',
            artist_type => 'Select'
        },
        optional => {
            start     => '+MusicBrainz::Server::Form::Field::Date',
            end       => '+MusicBrainz::Server::Form::Field::Date',
            edit_note => 'TextArea',

            # We make this required if duplicates are found,
            # or if a resolution is present when we edit the artist.
            resolution => {
                type             => 'Text',
                required_message => 'An artist with this name already exists. '.
                                    'Please enter a comment about this artist for disambiguation',
            },
        }
    };
}

=head2 options_artist_type

Options used for the "artist type" combo field.

=cut

sub options_artist_type
{
    [ MusicBrainz::Server::Artist::ARTIST_TYPE_PERSON, "Person",
      MusicBrainz::Server::Artist::ARTIST_TYPE_GROUP, "Group",
      MusicBrainz::Server::Artist::ARTIST_TYPE_UNKNOWN, "Unknown" ]
}

=head2 model_validate

If the new artist name already exists, make sure that the resolution field
is required

=cut

sub model_validate
{
    my $self = shift;

    my $artist = MusicBrainz::Server::Artist->new($self->context->mb->{DBH});
    my $artists = $artist->select_artists_by_name($self->value('name'));

    my @dupes;
    for my $possible_dupe (@$artists)
    {
        push @dupes, $possible_dupe
            if ($possible_dupe->id != $self->item_id);
    }

    if (scalar @dupes)
    {
        $self->field('resolution')->required(1);
        $self->field('resolution')->validate_field;
    }
}

=head2 init_value

Initialize the value for a form field, given the name of the field.

=cut

sub init_value
{
    my ($self, $field, $item) = @_;
    $item ||= $self->item;

    return unless defined $item;
    
    use Switch;
    switch($field->name)
    {
        return $item->name case ('name');
        return $item->sort_name case('sortname');
        return $item->type case('artist_type');
        return $item->begin_date case('start');
        return $item->end_date case('end');
        case('resolution') {
            my $resolution = $item->resolution;
            $field->required(1) if $resolution;
            return $resolution;
        };
    }
}

=head1 LICENSE 

This software is provided "as is", without warranty of any kind, express or
implied, including  but not limited  to the warranties of  merchantability,
fitness for a particular purpose and noninfringement. In no event shall the
authors or  copyright  holders be  liable for any claim,  damages or  other
liability, whether  in an  action of  contract, tort  or otherwise, arising
from,  out of  or in  connection with  the software or  the  use  or  other
dealings in the software.

GPL - The GNU General Public License    http://www.gnu.org/licenses/gpl.txt
Permits anyone the right to use and modify the software without limitations
as long as proper  credits are given  and the original  and modified source
code are included. Requires  that the final product, software derivate from
the original  source or any  software  utilizing a GPL  component, such  as
this, is also licensed under the GPL license.

=cut

1;

