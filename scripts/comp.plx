use Font::Fret;

fret('Font::Composites', @ARGV);

package Font::Composites;

BEGIN {
    @ISA = qw(Font::Fret::Default);
    $VERSION = "1.000";
      }

sub row2hdr
{
    my ($class, $font) = @_;

    return ("PSName", "Num", "Composite1", "Composite2", "Composite3");
}

sub row2
{
    my ($class, $cid, $gid, $glyph, $uid, $font) = @_;
    my ($num) = $glyph->{'numberOfContours'};
    my ($i, $comp, @comp, $rest);

    if ($num >= 0)
    { return ($font->{'post'}{'VAL'}[$gid]); }
    else
    {
        $glyph->read_dat;
        $num = $glyph->{'numPoints'};
        for ($i = 0; $i < $num; $i++)
        {
            $comp = $glyph->{'comps'}[$i];
            $rest = "$comp->{'args'}[0],$comp->{'args'}[1]";
            $rest .= "-" if ($comp->{'flag'} & 1024);
            if ($comp->{'flag'} & 200)
            {
                map {$_ *= 100} @{$comp->{'scale'}};
                if ($comp->{'flag'} & 8)
                { $rest .= "%" . sprintf("%.1f", $comp->{'scale'}[0]); }
                elsif ($comp->{'flag'} & 64)
                { $rest .= "%" . sprintf("%.1f/%.1f", $comp->{'scale'}[0,3]); }
                if ($comp->{'flag'} & 128)
                { $rest .= "%" . sprintf("(%.1f,%.1f,%.1f,%.1f)", @{$comp->{'scale'}}); }
            }
            $comp[$i] = $comp->{'glyph'} . ($comp->{'flag'} & 2 ? "@" : "P")
                        . $rest;
        }
    return ($font->{'post'}{'VAL'}[$gid], $num, $comp[0], $comp[1], $comp[2]);
    }
}

