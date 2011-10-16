# encoding: utf-8

class Link < ActiveRecord::Base

  belongs_to :user
  belongs_to :partner
  has_many :cliks

IPv4_PART = /\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]/
ALNUM = "ä".match(/[[:alnum:]]/) ? /[[:alnum:]]/ : /[^\W_]/

#DOMAIN = /([a-z0-9\-]+\.?)*([a-z0-9]{2,})\.[a-z]{2,}/
DOMAIN =/(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|eu|asia|pro|ac|ad|ae|aero|af|ag|ai|al|am|an|ao|aq|ar|arpa|as|asia|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|bi|biz|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cat|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|co|com|coop|cr|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|edu|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gov|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|in|info|int|io|iq|ir|is|it|je|jm|jo|jobs|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mil|mk|ml|mm|mn|mo|mobi|mp|mq|mr|ms|mt|mu|museum|mv|mw|mx|my|mz|na|name|nc|ne|net|nf|ng|ni|nl|no|np|nr|nu|nz|om|org|pa|pe|pf|pg|ph|pk|pl|pm|pn|pr|pro|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tel|tf|tg|th|tj|tk|tl|tm|tn|to|tp|tr|travel|tt|tv|tw|tz|ua|ug|uk|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|xxx|ye|yt|za|zm|zw|рф)/

  REGEXP = %r{
    \A
    (https?://)?                                                          # http:// or https://
    ([^\s:@]+:[^\s:@]*@)?                                              # optional username:pw@
    ( ((#{ALNUM}+\.)*xn--)?#{ALNUM}{2,}([-.]#{ALNUM}+)*\.#{DOMAIN}\.? |  # domain (including Punycode/IDN)...
        (#{IPv4_PART}(\.#{IPv4_PART}){3}) )                              # or IPv4
    (:\d{1,5})?                                                        # optional port
    ([/?]\S*)?                                                         # optional /whatever or ?whatever
    \Z
  }iux

#####
#    ( ((#{ALNUM}+\.)*xn--)?#{ALNUM}+([-.]#{ALNUM}+)*\.[a-zа-я]{2,6}\.? |  # domain (including Punycode/IDN)...


#####



before_validation  {self.link.strip!}

	validates :link, :presence => true , :format => {:with => /#{REGEXP}/, :message => "Некорректный формат партнерской ссылки"}

public

def get_nonactive_links
	Link.where(:active=>false)
end

end

