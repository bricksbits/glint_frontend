import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class InterestedPeopleListTiles extends StatefulWidget {
  const InterestedPeopleListTiles({
    super.key,
    this.limitCount,
  });

  final int? limitCount;

  @override
  State<InterestedPeopleListTiles> createState() =>
      _InterestedPeopleListTilesState();
}

class _InterestedPeopleListTilesState extends State<InterestedPeopleListTiles> {
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: widget.limitCount == null
          ? null
          : const NeverScrollableScrollPhysics(),
      itemCount: widget.limitCount ?? interestedPeople.length,
      itemBuilder: (context, index) {
        final person = interestedPeople[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: _buildProfileRow(
              profileImageUrl: person['imageUrl']!,
              name: person['name']!,
              email: person['email']!),
        );
      },
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
