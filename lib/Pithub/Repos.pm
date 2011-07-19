package Pithub::Repos;

# ABSTRACT: Github v3 Repos API

use Moo;
use Carp qw(croak);
use Pithub::Repos::Collaborators;
use Pithub::Repos::Commits;
use Pithub::Repos::Downloads;
use Pithub::Repos::Forks;
use Pithub::Repos::Keys;
use Pithub::Repos::Watching;
extends 'Pithub::Base';

=method branches

=over

=item *

List Branches

    GET /repos/:user/:repo/branches

Examples:

    my $repos  = Pithub::Repos->new;
    my $result = $repos->branches( user => 'plu', repo => 'Pithub' );

=back

=cut

sub branches {
    my ( $self, %args ) = @_;
    $self->_validate_user_repo_args( \%args );
    return $self->request(
        method => 'GET',
        path   => sprintf( '/repos/%s/%s/branches', delete $args{user}, delete $args{repo} ),
        %args,
    );
}

=method collaborators

Provides access to L<Pithub::Repos::Collaborators>.

=cut

sub collaborators {
    return shift->_create_instance('Pithub::Repos::Collaborators');
}

=method commits

Provides access to L<Pithub::Repos::Commits>.

=cut

sub commits {
    return shift->_create_instance('Pithub::Repos::Commits');
}

=method contributors

=over

=item *

List contributors

    GET /repos/:user/:repo/contributors

Examples:

    my $repos  = Pithub::Repos->new;
    my $result = $repos->contributors( user => 'plu', repo => 'Pithub' );

=back

=cut

sub contributors {
    my ( $self, %args ) = @_;
    $self->_validate_user_repo_args( \%args );
    return $self->request(
        method => 'GET',
        path   => sprintf( '/repos/%s/%s/contributors', delete $args{user}, delete $args{repo} ),
        %args,
    );
}

=method create

=over

=item *

Create a new repository for the authenticated user.

    POST /user/repos

Examples:

    my $repos  = Pithub::Repos->new;
    my $result = $repos->create( data => { name => 'some-repo' } );

=item *

Create a new repository in this organization. The authenticated user
must be a member of this organization.

    POST /orgs/:org/repos

Examples:

    my $repos  = Pithub::Repos->new;
    my $result = $repos->create(
        org  => 'CPAN-API',
        data => { name => 'some-repo' }
    );

=back

=cut

sub create {
    my ( $self, %args ) = @_;
    croak 'Missing key in parameters: data (hashref)' unless ref $args{data} eq 'HASH';
    if ( my $org = delete $args{org} ) {
        return $self->request(
            method => 'POST',
            path   => sprintf( '/orgs/%s/repos', $org ),
            %args,
        );
    }
    else {
        return $self->request(
            method => 'POST',
            path   => '/user/repos',
            %args,
        );
    }
}

=method downloads

Provides access to L<Pithub::Repos::Downloads>.

=cut

sub downloads {
    return shift->_create_instance('Pithub::Repos::Downloads');
}

=method forks

Provides access to L<Pithub::Repos::Forks>.

=cut

sub forks {
    return shift->_create_instance('Pithub::Repos::Forks');
}

=method get

=over

=item *

Get a repo

    GET /repos/:user/:repo

Examples:

    my $repos  = Pithub::Repos->new;
    my $result = $repos->get( user => 'plu', repo => 'Pithub' );

=back

=cut

sub get {
    my ( $self, %args ) = @_;
    $self->_validate_user_repo_args( \%args );
    return $self->request(
        method => 'GET',
        path   => sprintf( '/repos/%s/%s', delete $args{user}, delete $args{repo} ),
        %args,
    );
}

=method keys

Provides access to L<Pithub::Repos::Keys>.

=cut

sub keys {
    return shift->_create_instance('Pithub::Repos::Keys');
}

=method languages

=over

=item *

List languages

    GET /repos/:user/:repo/languages

Examples:

    my $repos  = Pithub::Repos->new;
    my $result = $repos->languages( user => 'plu', repo => 'Pithub' );

=back

=cut

sub languages {
    my ( $self, %args ) = @_;
    $self->_validate_user_repo_args( \%args );
    return $self->request(
        method => 'GET',
        path   => sprintf( '/repos/%s/%s/languages', delete $args{user}, delete $args{repo} ),
        %args,
    );
}

=method list

=over

=item *

List repositories for the authenticated user.

    GET /user/repos

Examples:

    my $repos  = Pithub::Repos->new;
    my $result = $repos->list;

=item *

List public repositories for the specified user.

    GET /users/:user/repos

Examples:

    my $repos  = Pithub::Repos->new;
    my $result = $repos->list( user => 'plu' );

=item *

List repositories for the specified org.

    GET /orgs/:org/repos

Examples:

    my $repos  = Pithub::Repos->new;
    my $result = $repos->list( org => 'CPAN-API' );

=back

=cut

sub list {
    my ( $self, %args ) = @_;
    if ( my $user = delete $args{user} ) {
        return $self->request(
            method => 'GET',
            path   => sprintf( '/users/%s/repos', $user ),
            %args,
        );
    }
    elsif ( my $org = delete $args{org} ) {
        return $self->request(
            method => 'GET',
            path   => sprintf( '/orgs/%s/repos', $org ),
            %args
        );
    }
    else {
        return $self->request(
            method => 'GET',
            path   => '/user/repos',
            %args,
        );
    }
}

=method tags

=over

=item *

List Tags

    GET /repos/:user/:repo/tags

Examples:

    my $repos  = Pithub::Repos->new;
    my $result = $repos->tags( user => 'plu', repo => 'Pithub' );

=back

=cut

sub tags {
    my ( $self, %args ) = @_;
    $self->_validate_user_repo_args( \%args );
    return $self->request(
        method => 'GET',
        path   => sprintf( '/repos/%s/%s/tags', delete $args{user}, delete $args{repo} ),
        %args,
    );
}

=method teams

=over

=item *

List Teams

    GET /repos/:user/:repo/teams

Examples:

    my $repos  = Pithub::Repos->new;
    my $result = $repos->teams( user => 'plu', repo => 'Pithub' );

=back

=cut

sub teams {
    my ( $self, %args ) = @_;
    $self->_validate_user_repo_args( \%args );
    return $self->request(
        method => 'GET',
        path   => sprintf( '/repos/%s/%s/teams', delete $args{user}, delete $args{repo} ),
        %args,
    );
}

=method update

=over

=item *

Edit

    PATCH /repos/:user/:repo

Examples:

    # update a repo for the authenticated user
    my $repos  = Pithub::Repos->new;
    my $result = $repos->update(
        repo => 'Pithub',
        data => { description => 'Github API v3' },
    );

=back

=cut

sub update {
    my ( $self, %args ) = @_;
    croak 'Missing key in parameters: data (hashref)' unless ref $args{data} eq 'HASH';
    $self->_validate_user_repo_args( \%args );
    return $self->request(
        method => 'PATCH',
        path   => sprintf( '/repos/%s/%s', delete $args{user}, delete $args{repo} ),
        %args,
    );
}

=method watching

Provides access to L<Pithub::Repos::Watching>.

=cut

sub watching {
    return shift->_create_instance('Pithub::Repos::Watching');
}

1;
