use Font::Fret;

fret('Font::Fret::Unicode', @ARGV);

package Font::Fret::Unicode;
BEGIN
{
    @ISA = qw(Font::Fret::Default);
    $VERSION = "1.000";
}

sub make_cids
{
    my ($class, $font) = @_;
    my (@res) = sort {$a <=> $b} keys %{$font->{'cmap'}->read->find_ms->{'val'}};

    return ("Unicode", @res);
}

sub cid_gid
{
    my ($class, $cid, $font) = @_;

    return $font->{'cmap'}->ms_lookup($cid);
}

