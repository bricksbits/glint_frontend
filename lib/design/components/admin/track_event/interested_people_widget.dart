import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class InterestedPeopleWidget extends StatelessWidget {
  const InterestedPeopleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> interestedPeople = [
      {
        'name': 'Shweta',
        'email': 'shweta22@email.com',
        'imageUrl':
            'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      },
      {
        'name': 'Riya',
        'email': 'riya2@email.com',
        'imageUrl':
            'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      },
      {
        'name': 'Shweta',
        'email': 'shweta22@email.com',
        'imageUrl':
            'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      },
      {
        'name': 'Riya',
        'email': 'riya2@email.com',
        'imageUrl':
            'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      },
      {
        'name': 'Shweta',
        'email': 'shweta22@email.com',
        'imageUrl':
            'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0).copyWith(
        bottom: 12.0,
      ),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppColours.borderGray,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Interested People',
              style: AppTheme.headingFour.copyWith(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          const Gap(20.0),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColours.borderGray,
                  width: 1.0,
                ),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final person = interestedPeople[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: _buildProfileRow(
                            profileImageUrl: person['imageUrl']!,
                            name: person['name']!,
                            email: person['email']!),
                      );
                    },
                  ),
                ),

                // white overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.2),
                          Colors.white.withValues(alpha: 0.4),
                          Colors.white.withValues(alpha: 0.8),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(12.0),
          InkWell(
            onTap: () {
              // todo = handle see all interested people tap
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'See all interested people',
                  style: AppTheme.simpleText.copyWith(
                    color: AppColours.primaryBlue,
                  ),
                ),
                const Gap(4.0),
                const Icon(
                  Icons.double_arrow_outlined,
                  color: AppColours.primaryBlue,
                  size: 12.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow({
    required String profileImageUrl,
    required String name,
    required String email,
  }) {
    return Row(
      children: [
        // profile picture
        CircleAvatar(
          radius: 14.0,
          backgroundImage: NetworkImage(profileImageUrl),
        ),

        const Gap(12.0),

        //profile name
        Text(
          name,
          style: AppTheme.simpleText,
        ),
        const Gap(12.0),
        const Text(
          ' | ',
          style: AppTheme.simpleText,
        ),
        const Gap(8.0),
        //email
        Text(
          email,
          style: AppTheme.simpleText.copyWith(
            color: AppColours.gray,
          ),
        ),
      ],
    );
  }
}
